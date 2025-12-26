package ph.servoitsolutions.zeus_app

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.epson.epos2.Epos2Exception
import com.epson.epos2.printer.Printer
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import okhttp3.WebSocket
import okhttp3.WebSocketListener
import org.json.JSONException
import org.json.JSONObject
import java.util.concurrent.TimeUnit

class WebSocketService : Service() {

    private val TAG = "WebSocketService"

    private var webSocket: WebSocket? = null
    private val client = OkHttpClient.Builder()
        .pingInterval(30, TimeUnit.SECONDS)
        .build()

    private var isConnected = false
    private val agentId = "agent_001"
    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

    private val CHANNEL_ID = "websocket_service_channel"
    private val NOTIFICATION_ID = 101

    // Epson printer instance
    private var printer: Printer? = null

    companion object {
        private var instance: WebSocketService? = null

        /**
         * Called from Flutter to send JSON-formatted messages through the WebSocket
         */
        fun sendMessageToWebSocket(json: String) {
            instance?.let {
                try {
                    val jsonText = JSONObject(json)
                    jsonText.put("jobId", System.currentTimeMillis().toString())
                    jsonText.put("sentAt", System.currentTimeMillis())
                    jsonText.put("sentTo", System.currentTimeMillis())

                    if (it.isConnected && it.webSocket != null) {
                        it.sendMessage(jsonText.toString())
                    } else {
                        Log.w("WebSocketService", "Socket not connected yet.")
                    }
                } catch (e: Exception) {
                    Log.e("WebSocketService", "Invalid JSON format", e)
                }
            }
        }

        fun initPrinter() {
            instance?.let {
                try {
                    it._initPrinter(it)
                } catch (e: Exception) {
                    Log.e("WebSocketService", "Invalid JSON format", e)
                }
            }
        }

        fun connectPrinter(ip: String) {
            instance?.let {
                try {
                    it._connectPrinter(ip)
                } catch (e: Exception) {
                    Log.e("WebSocketService", "Invalid JSON format", e)
                }
            }
        }

        fun disconnectPrinter() {
            instance?.let {
                try {
                    it._disconnectPrinter()
                } catch (e: Exception) {
                    Log.e("WebSocketService", "Invalid JSON format", e)
                }
            }
        }

        fun printReceipt() {
            instance?.let {
                try {
                    // Optional test print after connection
                    val payload: Map<String, Any> = mapOf(
                        "receiptType" to "Invoice",
                        "header" to mapOf(
                            "propertyName" to "Test Property",
                            "owner" to "Test Owner",
                            "street" to "123 Test Street",
                            "barangay" to "Barangay Uno",
                            "city" to "Test City",
                            "province" to "Test Province",
                            "TIN" to "123-456-789",
                            "machineNo" to "MCH-001",
                            "MIN" to "MIN-12345"
                        ),
                        "invoiceNo" to "INV-2025-001",
                        "guestName" to "John Doe",
                        "pax" to "3",
                        "tableNo" to "A12",
                        "orderType" to "Dine In",
                        "date" to "2025-11-13",
                        "time" to "11:45 AM",
                        "cashier" to "Jane Smith",
                        "totalPayables" to "450.00",
                        "change" to "50.00",

                        // ITEMS SECTION
                        "items" to listOf(
                            mapOf(
                                "name" to "Cheeseburger",
                                "qty" to 2,
                                "price" to 150.0,
                                "subtotal" to 300.0
                            ),
                            mapOf(
                                "name" to "French Fries",
                                "qty" to 1,
                                "price" to 80.0,
                                "subtotal" to 80.0
                            ),
                            mapOf(
                                "name" to "Soft Drink",
                                "qty" to 2,
                                "price" to 35.0,
                                "subtotal" to 70.0
                            )
                        ),

                        // PAYMENTS SECTION
                        "payments" to listOf(
                            mapOf(
                                "method" to "Cash",
                                "amount" to 500.0
                            ),
                            mapOf(
                                "method" to "GCash",
                                "amount" to 100.0
                            )
                        ),

                        // BREAKDOWN SECTION
                        "breakdown" to listOf(
                            mapOf(
                                "label" to "Subtotal",
                                "amount" to 450.0
                            ),
                            mapOf(
                                "label" to "VAT (12%)",
                                "amount" to 54.0
                            ),
                            mapOf(
                                "label" to "Service Charge",
                                "amount" to 20.0
                            ),
                            mapOf(
                                "label" to "Total",
                                "amount" to 524.0
                            )
                        ),

                        "approvedBy" to "Manager Name",
                        "printedDateTime" to "2025-11-13 11:50 AM",
                        "rePrintedBy" to "Admin",
                        "rePrintedDateTime" to "2025-11-13 12:00 PM",
                        "transNo" to "TXN-001",
                        "separatorNo" to "SEP-001",
                        "isReprint" to false,
                        "printerName" to "TM-T82",
                        "qr" to "https://servoitsolutions.ph/"
                    )
                    // Wrap it into a parent JSON for WebSocket or direct print command
                    val jsonData = JSONObject(
                        mapOf(
                            "type" to "print",
                            "jobId" to "testJob001",
                            "payload" to payload
                        )
                    )
                    // Step 3: Call your print command handler
                    it._handlePrintCommand(jsonData)
                } catch (e: Exception) {
                    Log.e("WebSocketService", "Invalid JSON format", e)
                }
            }
        }
    }

    // --- Service Lifecycle ------------------------------------------------------

    override fun onCreate() {
        super.onCreate()
        instance = this
        startForegroundServiceNotification()
        connectWebSocket()
        Log.d(TAG, "Service created")
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d(TAG, "Service started (foreground)")
        return START_STICKY
    }

    override fun onDestroy() {
        disconnectWebSocket()
        serviceScope.cancel()
        instance = null
        Log.d(TAG, "Service destroyed")
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    // --- Foreground Notification ------------------------------------------------

    private fun startForegroundServiceNotification() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "WebSocket Service",
                NotificationManager.IMPORTANCE_LOW
            )
            getSystemService(NotificationManager::class.java).createNotificationChannel(channel)
        }

        val pendingIntent = PendingIntent.getActivity(
            this, 0, Intent(this, MainActivity::class.java),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        val notification: Notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("WebSocket Service")
            .setContentText("Listening for print jobs…")
            .setSmallIcon(android.R.drawable.stat_notify_sync)
            .setContentIntent(pendingIntent)
            .setOngoing(true)
            .build()

        startForeground(NOTIFICATION_ID, notification)
    }

    // --- WebSocket Connection ---------------------------------------------------

    private fun connectWebSocket(port: Int = 3000) {
        val url = "ws://192.168.11.40:$port?agentId=$agentId"
        val request = Request.Builder().url(url).build()

        webSocket = client.newWebSocket(request, object : WebSocketListener() {
            override fun onOpen(webSocket: WebSocket, response: Response) {
                isConnected = true
                Log.d(TAG, "Connected to $url")
                registerAgent()

                // Optional test print after connection
                val payload: Map<String, Any> = mapOf(
                    "receiptType" to "Invoice",
                    "header" to mapOf(
                        "propertyName" to "Test Property",
                        "owner" to "Test Owner",
                        "street" to "123 Test Street",
                        "barangay" to "Barangay Uno",
                        "city" to "Test City",
                        "province" to "Test Province",
                        "TIN" to "123-456-789",
                        "machineNo" to "MCH-001",
                        "MIN" to "MIN-12345"
                    ),
                    "invoiceNo" to "INV-2025-001",
                    "guestName" to "John Doe",
                    "pax" to "3",
                    "tableNo" to "A12",
                    "orderType" to "Dine In",
                    "date" to "2025-11-13",
                    "time" to "11:45 AM",
                    "cashier" to "Jane Smith",
                    "totalPayables" to "450.00",
                    "change" to "50.00",

                    // ITEMS SECTION
                    "items" to listOf(
                        mapOf(
                            "name" to "Cheeseburger",
                            "qty" to 2,
                            "price" to 150.0,
                            "subtotal" to 300.0
                        ),
                        mapOf(
                            "name" to "French Fries",
                            "qty" to 1,
                            "price" to 80.0,
                            "subtotal" to 80.0
                        ),
                        mapOf(
                            "name" to "Soft Drink",
                            "qty" to 2,
                            "price" to 35.0,
                            "subtotal" to 70.0
                        )
                    ),

                    // PAYMENTS SECTION
                    "payments" to listOf(
                        mapOf(
                            "method" to "Cash",
                            "amount" to 500.0
                        ),
                        mapOf(
                            "method" to "GCash",
                            "amount" to 100.0
                        )
                    ),

                    // BREAKDOWN SECTION
                    "breakdown" to listOf(
                        mapOf(
                            "label" to "Subtotal",
                            "amount" to 450.0
                        ),
                        mapOf(
                            "label" to "VAT (12%)",
                            "amount" to 54.0
                        ),
                        mapOf(
                            "label" to "Service Charge",
                            "amount" to 20.0
                        ),
                        mapOf(
                            "label" to "Total",
                            "amount" to 524.0
                        )
                    ),

                    "approvedBy" to "Manager Name",
                    "printedDateTime" to "2025-11-13 11:50 AM",
                    "rePrintedBy" to "Admin",
                    "rePrintedDateTime" to "2025-11-13 12:00 PM",
                    "transNo" to "TXN-001",
                    "separatorNo" to "SEP-001",
                    "isReprint" to false,
                    "printerName" to "TM-T82",
                    "qr" to "https://servoitsolutions.ph/"
                )
                // Wrap it into a parent JSON for WebSocket or direct print command
                val jsonData = JSONObject(
                    mapOf(
                        "type" to "print",
                        "jobId" to "testJob001",
                        "payload" to payload
                    )
                )

                // Call your printer command
                _handlePrintCommand(jsonData)
            }

            override fun onMessage(webSocket: WebSocket, text: String) {
                Log.d(TAG, "Message: $text")
                try {
                    val json = JSONObject(text)
                    when (json.getString("type")) {
                        "print" -> _handlePrintCommand(json)
                        else -> Log.w(TAG, "Unknown message type: ${json.getString("type")}")
                    }
                } catch (e: JSONException) {
                    Log.e(TAG, "Invalid JSON: $text", e)
                }
            }

            override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
                Log.e(TAG, "WebSocket failure: ${t.message}")
                isConnected = false
                reconnectWithDelay()
            }

            override fun onClosed(webSocket: WebSocket, code: Int, reason: String) {
                Log.d(TAG, "WebSocket closed: $code / $reason")
                isConnected = false
                reconnectWithDelay()
            }
        })
    }

    private fun reconnectWithDelay() {
        serviceScope.launch {
            delay(5000L)
            Log.d(TAG, "Reconnecting WebSocket…")
            connectWebSocket()
        }
    }

    private fun disconnectWebSocket() {
        webSocket?.close(1000, "Service stopped")
        webSocket = null
        isConnected = false
    }

    private fun sendMessage(jsonText: String) {
        if (!isConnected || webSocket == null) return
        webSocket?.send(jsonText)
        Log.d(TAG, "Sent: $jsonText")
    }

    private fun registerAgent() {
        if (!isConnected || webSocket == null) return
        val msg = JSONObject().apply {
            put("type", "register")
            put("name", agentId)
        }
        webSocket?.send(msg.toString())
        Log.d(TAG, "Registered agent: $msg")
    }

    // --- Print Command Handler --------------------------------------------------

    private fun _handlePrintCommand(data: JSONObject) {
        val printerIp = "192.168.12.200"
        val jobId = data.optString("jobId", "N/A")
        val payload = data.optJSONObject("payload")

        serviceScope.launch {
            val context = this@WebSocketService

            if (!_initPrinter(context)) return@launch
            if (!_connectPrinter(printerIp)) {
                _disconnectPrinter()
                return@launch
            }

            if (payload != null) {
                val receiptType = payload.optString("receiptType", "")
                try {
                    when (receiptType) {
                        "Order Slip" -> PrinterTemplates().printOrderSlip(payload, printer)
                        "Void OS" -> PrinterTemplates().printVoidOS(payload, printer)
                        "Void Slip" -> PrinterTemplates().printVoidSlip(payload, printer)
                        "Void Invoice" -> PrinterTemplates().printVoidInvoice(payload, printer)
                        "Billing Slip" -> PrinterTemplates().printBillingSlip(payload, printer)
                        "Voided Charge Slip" -> PrinterTemplates().printVoidedChargeSlip(
                            payload,
                            printer
                        )

                        "Charge to Room" -> PrinterTemplates().printChargeToRoom(payload, printer)
                        "Charge to Account" -> PrinterTemplates().printChargeToAccount(
                            payload,
                            printer
                        )

                        "Invoice" -> PrinterTemplates().printInvoice(payload, printer)
                        "Collection Receipt" -> PrinterTemplates().printCollectionReceipt(
                            payload,
                            printer
                        )

                        "Z Reading" -> PrinterTemplates().printZReading(payload, printer)
                        else -> Log.w(TAG, "Unknown receipt type: $receiptType")
                    }
                } catch (e: Exception) {
                    Log.e(TAG, "Error printing $receiptType: ${e.message}", e)
                }
            } else {
                Log.w(TAG, "Missing print payload")
            }

            _disconnectPrinter()

            // Acknowledge job completion
            sendMessage(
                JSONObject().apply {
                    put("type", "print-completed")
                    put("jobId", jobId)
                    put("status", "done")
                }.toString()
            )
        }
    }

    // --- Epson Printer Helpers --------------------------------------------------

    private fun _initPrinter(context: Context, printerModel: Int = Printer.TM_T82): Boolean {
        return try {
            printer = Printer(printerModel, Printer.LANG_EN, context)
            true
        } catch (e: Epos2Exception) {
            Log.e("EpsonPrinter", "Init failed: ${e.errorStatus}")
            false
        } catch (e: Exception) {
            Log.e("EpsonPrinter", "Init exception: ${e.message}")
            false
        }
    }

    private fun _connectPrinter(printerIp: String): Boolean {
        return try {
            val target = "TCP:$printerIp"
            printer?.connect(target, Printer.PARAM_DEFAULT)
            printer?.beginTransaction()
            Log.d("EpsonPrinter", "Connected to printer at $target")
            true
        } catch (e: Epos2Exception) {
            Log.e("EpsonPrinter", "Connect failed: ${e.errorStatus}")
            false
        } catch (e: Exception) {
            Log.e("EpsonPrinter", "Connect exception: ${e.message}")
            false
        }
    }

    private fun _disconnectPrinter() {
        try {
            printer?.endTransaction()
            printer?.disconnect()
            Log.d("EpsonPrinter", "Printer disconnected")
        } catch (e: Epos2Exception) {
            Log.e("EpsonPrinter", "Disconnect error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e("EpsonPrinter", "Disconnect exception: ${e.message}")
        } finally {
            printer = null
        }
    }
}
