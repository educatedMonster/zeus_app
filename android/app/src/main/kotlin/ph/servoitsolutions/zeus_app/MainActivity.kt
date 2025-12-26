package ph.servoitsolutions.zeus_app

import android.content.Intent
import android.os.Build
import androidx.annotation.NonNull
import com.epson.epos2.printer.Printer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "web_socket_service"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            when (call.method) {
                "getPlatformVersion" -> {
                    val release = Build.VERSION.RELEASE
                    val sdk = Build.VERSION.SDK_INT
                    result.success("Android $release (SDK $sdk)")
                }

                "startWebbSocketService" -> {
                    val intent = Intent(this, WebSocketService::class.java)
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        startForegroundService(intent)
                    } else {
                        startService(intent)
                    }
                    result.success("WebSocketService started!")
                }

                "stopWebSocketService" -> {
                    stopService(Intent(this, WebSocketService::class.java))
                    result.success("WebSocketService stopped!")
                }

                "sendMessage" -> {
                    val json = call.argument<String>("json") ?: ""
                    WebSocketService.sendMessageToWebSocket(json)
                    result.success("Message sent: $json")
                }

                "initPrinter" -> {
                    WebSocketService.initPrinter()
                    result.success("Successfully printed!")
                }

                "connectPrinter" -> {
                    val ip = call.argument<String>("ip") ?: ""
                    WebSocketService.connectPrinter(ip)
                    result.success("Successfully printed!")
                }

                "disconnectPrinter" -> {
                    WebSocketService.disconnectPrinter()
                    result.success("Successfully printed!")
                }

                "printReceipt" -> {
                    WebSocketService.printReceipt()
                    result.success("Successfully printed!")
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
