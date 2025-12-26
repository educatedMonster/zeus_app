package ph.servoitsolutions.zeus_app

import android.util.Log
import com.epson.epos2.Epos2Exception
import com.epson.epos2.printer.Printer
import org.json.JSONObject

/**
 * Base template functions for different receipt types.
 * Each function receives the payload as JSONObject.
 * You can implement the Epson printing commands inside each function.
 */

class PrinterTemplates() {

    private val TAG_PRINTER: String = "EpsonPrinterTemplates"

    // --- Order Slip ---
    fun printOrderSlip(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                // TODO: Add Epson commands for Order Slip
                val receiptType = payload.optString("receiptType")
                val orderSlipNo = payload.optString("orderSlipNo", "")
                val source = payload.optString("source", "")
                val tableNo = payload.optString("tableNo", "")
                val guestName = payload.optString("guestName", "")
                val orderType = payload.optString("orderType", "")
                val items = payload.optJSONArray("items") ?: return
                val printedBy = payload.optString("printedBy", "")
                val printedDateTime = payload.optString("printedDateTime", "")
                val rePrintedBy = payload.optString("rePrintedBy", "")
                val rePrintedDateTime = payload.optString("rePrintedDateTime", "")
                val transNo = payload.optString("transNo", "")
                val separatorNo = payload.optInt("separatorNo", 48)
                val isReprint = payload.optBoolean("isReprint", false)

                printer.clearCommandBuffer()

                // Header section
                printer.addTextAlign(Printer.ALIGN_LEFT)
                printer.addText("Order Slip No: $orderSlipNo\n")
                printer.addText("Source: $source\n")
                printer.addText("Table Number: $tableNo\n")
                printer.addText("Guest Name: $guestName\n")
                printer.addText(separatorLine(separatorNo))

                // Title
                printer.addTextAlign(Printer.ALIGN_CENTER)
                printer.addTextStyle(Printer.FALSE, Printer.FALSE, Printer.TRUE, Printer.COLOR_1)
                printer.addTextSize(2, 2)
                printer.addText("$orderType ${if (isReprint) "/ REPRINT" else ""}\n")
                printer.addTextSize(1, 1)
                printer.addTextStyle(Printer.FALSE, Printer.FALSE, Printer.FALSE, Printer.COLOR_1)

                if (separatorNo != 48) {
                    printer.addTextFont(Printer.FONT_B)
                }

                printer.addTextAlign(Printer.ALIGN_LEFT)
                printer.addText(separatorLine(separatorNo))
                printer.addText("Please serve the following\n")
                printer.addText(separatorEqual(separatorNo))

                // --- Items ---
                printer.addTextSize(2, 2)
                for (i in 0 until items.length()) {
                    val item = items.getJSONObject(i)
                    val qty = item.optInt("quantity", 0)
                    val desc = item.optString("description", "")
                    printer.addText("$qty  $desc\n")
                }

                printer.addTextSize(1, 1)
                printer.addText(separatorEqual(separatorNo))

                // Footer section
                printer.addText("Printed By: $printedBy\n")
                printer.addText("Print Date/Time: $printedDateTime\n")
                printer.addTextAlign(Printer.ALIGN_CENTER)
                printer.addText("TN: $transNo\n")

                if (isReprint) {
                    addText("*** REPRINTED COPY ***\n")
                    addText("Reprinted by: ${rePrintedBy}\n")
                    addText("Reprinted on: ${rePrintedDateTime}\n")
                }

                // Cut paper
                addFeedLine(3)
                addCut(Printer.CUT_FEED)

                sendData(Printer.PARAM_DEFAULT)

                Log.d("EpsonPrinter", "Receipt printed successfully")
            }
        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Epson print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Print exception: ${e.message}")
        }
    }

    // --- Void OS ---
    fun printVoidOS(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                Log.d(TAG_PRINTER, "Printing Void OS...")
                // TODO: Add Epson commands for Void OS
                sendData(Printer.PARAM_DEFAULT)
            }
        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Void OS print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Void OS print exception: ${e.message}")
        }
    }

    // --- Void Slip ---
    fun printVoidSlip(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                Log.d(TAG_PRINTER, "Printing Void Slip...")
                // TODO: Add Epson commands for Void Slip
                sendData(Printer.PARAM_DEFAULT)
            }
        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Void Slip print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Void Slip print exception: ${e.message}")
        }
    }

    // --- Void Invoice ---
    fun printVoidInvoice(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                Log.d(TAG_PRINTER, "Printing Void Invoice...")
                // TODO: Add Epson commands for Void Invoice
                sendData(Printer.PARAM_DEFAULT)
            }
        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Void Invoice print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Void Invoice print exception: ${e.message}")
        }
    }

    // --- Billing Slip ---
    fun printBillingSlip(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                // TODO: Add Epson commands for Billing Slip
                val pax = payload.optString("pax", "")
                val date = payload.optString("date", "")
                val time = payload.optString("time", "")
                val cashier = payload.optString("cashier", "")
                val tableNo = payload.optString("tableNo", "")
                val transNo = payload.optString("transNo", "")
                val guestName = payload.optString("guestName", "")
                val referenceNo = payload.optString("referenceNo", "")
                val orderType = payload.optString("orderType", "")
                val separatorNo = payload.optInt("separatorNo", 48)
                val change = payload.optDouble("change", 0.0)
                val totalPayables = payload.optDouble("totalPayables", 0.0)
                val isReprint = payload.optBoolean("isReprint", false)

                val header = payload.optJSONObject("header") ?: JSONObject()
                val propertyName = header.optString("propertyName", "")
                val owner = header.optString("owner", "")
                val street = header.optString("street", "")
                val barangay = header.optString("barangay", "")
                val city = header.optString("city", "")
                val province = header.optString("province", "")
                val TIN = header.optString("TIN", "")
                val machineNo = header.optString("machineNo", "")
                val MIN = header.optString("MIN", "")

                val breakdown = payload.optJSONObject("breakdown") ?: JSONObject()
                val grossAmount = breakdown.optDouble("grossAmount", 0.0)
                val vatable = breakdown.optDouble("vatable", 0.0)
                val vatAmount = breakdown.optDouble("vatAmount", 0.0)
                val vatExempt = breakdown.optDouble("vatExempt", 0.0)
                val zeroRated = breakdown.optDouble("zeroRated", 0.0)
                val serviceCharge = breakdown.optDouble("serviceCharge", 0.0)
                val localTax = breakdown.optDouble("localTax", 0.0)

                val items = payload.optJSONArray("items") ?: return

                printer.clearCommandBuffer()

                // ===== HEADER =====
                printer.addTextAlign(Printer.ALIGN_CENTER)
                printer.addText("$propertyName\n")
                printer.addText("$owner\n")
                printer.addText("$street\n")
                printer.addText("$barangay\n")
                printer.addText("$city\n")
                printer.addText("$province\n")
                printer.addText("TIN: $TIN\n")
                printer.addText("Machine No: $machineNo\n")
                printer.addText("MIN: $MIN\n\n")

                printer.addTextSize(2, 2)
                printer.addText("BILLING SLIP ${if (isReprint) "/ REPRINT" else ""}\n")
                printer.addTextSize(1, 1)
                printer.addText(separatorLine(separatorNo))

                // ===== INFO LINES =====
                printer.addText(
                    formatColumns(
                        listOf("Guest: $guestName", "Pax: $pax"),
                        listOf(1, 2),
                        separatorNo
                    )
                )
                printer.addText(
                    formatColumns(
                        listOf("Table No: $tableNo", orderType),
                        listOf(1, 2),
                        separatorNo
                    )
                )
                printer.addText(
                    formatColumns(
                        listOf("Date: $date", "Time: $time"),
                        listOf(1, 2),
                        separatorNo
                    )
                )
                printer.addText("Cashier: $cashier\n")
                printer.addText(separatorEqual(separatorNo))

                // ===== ITEM HEADER =====
                printer.addText(
                    formatColumns(
                        listOf("Qty", "Item", "Amount"),
                        listOf(1, 3, 2),
                        separatorNo
                    )
                )
                printer.addText(separatorEqual(separatorNo))

                // ===== ITEMS =====
                for (i in 0 until items.length()) {
                    val item = items.getJSONObject(i)
                    val qty = item.optInt("quantity", 0)
                    val desc = item.optString("description", "")
                    val amount = item.optDouble("amount", 0.0)

                    printer.addText(
                        formatColumns(
                            listOf("$qty", desc, "%.2f".format(amount)),
                            listOf(1, 3, 2),
                            separatorNo
                        )
                    )
                }

                printer.addText(separatorEqual(separatorNo))

                // ===== TOTALS =====
                printer.addTextSize(2, 2)
                printer.addText(
                    formatColumnsRight(
                        listOf(
                            "Total Payables:",
                            "%.2f".format(totalPayables)
                        ), separatorNo
                    )
                )
                printer.addTextSize(1, 1)
                printer.addText(separatorEqual(separatorNo))

                // ===== VAT Breakdown =====
                printer.addText(
                    formatColumnsRight(
                        listOf("Gross Amount:", "%.2f".format(grossAmount)),
                        separatorNo
                    )
                )
                if (vatable > 0) printer?.addText(
                    formatColumnsRight(
                        listOf(
                            "VATable Sales:",
                            "%.2f".format(vatable)
                        ), separatorNo
                    )
                )
                printer.addText(
                    formatColumnsRight(
                        listOf("VAT Amount:", "%.2f".format(vatAmount)),
                        separatorNo
                    )
                )
                if (vatExempt > 0) printer.addText(
                    formatColumnsRight(
                        listOf(
                            "VAT-Exempt Sales:",
                            "%.2f".format(vatExempt)
                        ), separatorNo
                    )
                )
                if (zeroRated > 0) printer.addText(
                    formatColumnsRight(
                        listOf(
                            "Zero-Rated Sales:",
                            "%.2f".format(zeroRated)
                        ), separatorNo
                    )
                )
                printer.addText(
                    formatColumnsRight(
                        listOf(
                            "Service Charge:",
                            "%.2f".format(serviceCharge)
                        ), separatorNo
                    )
                )
                printer.addText(
                    formatColumnsRight(
                        listOf("Local Tax:", "%.2f".format(localTax)),
                        separatorNo
                    )
                )
                printer.addText(separatorEqual(separatorNo))

                // ===== SIGNATURE =====
                printer.addText("Payment/Billing Instructions:\n")
//                printer.addText(formatUnderline('', separatorNo))
                printer.addFeedLine(1)
                printer.addTextAlign(Printer.ALIGN_CENTER)

                // ===== FOOTER =====
                printer.addText("THIS IS NOT AN INVOICE\n")
                printer.addText("TN: $transNo\n")
                printer.addText("THIS DOCUMENT IS NOT\n")
                printer.addText("VALID FOR CLAIM OF INPUT TAX\n")
                printer.addText("THIS IS NOT AN INVOICE\n")

                printer.addCut(Printer.CUT_FEED)

                printer.sendData(Printer.PARAM_DEFAULT)

                Log.d("EpsonPrinter", "Billing slip printed successfully")
            }

        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Epson print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Print exception: ${e.message}")
        }
    }

    // --- Voided Charge Slip ---
    fun printVoidedChargeSlip(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                Log.d(TAG_PRINTER, "Printing Voided Charge Slip...")
                // TODO: Add Epson commands for Voided Charge Slip
                sendData(Printer.PARAM_DEFAULT)
            }
        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Voided Charge Slip print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Voided Charge Slip print exception: ${e.message}")
        }
    }

    // --- Charge to Room ---
    fun printChargeToRoom(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                Log.d(TAG_PRINTER, "Printing Charge to Room...")
                // TODO: Add Epson commands for Charge to Room
                sendData(Printer.PARAM_DEFAULT)
            }
        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Charge to Room print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Charge to Room print exception: ${e.message}")
        }
    }

    // --- Charge to Account ---
    fun printChargeToAccount(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                Log.d(TAG_PRINTER, "Printing Charge to Account...")
                // TODO: Add Epson commands for Charge to Account
                sendData(Printer.PARAM_DEFAULT)
            }
        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Charge to Account print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Charge to Account print exception: ${e.message}")
        }
    }

    // --- Invoice ---
    fun printInvoice(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                Log.d(TAG_PRINTER, "Printing Invoice...")
                // TODO: Add Epson commands or call your Invoice here
                val receiptType = payload.optString("receiptType", "")

                // --- HEADER INFO ---
                val header = payload.optJSONObject("header")
                val propertyName = header?.optString("propertyName", "") ?: ""
                val owner = header?.optString("owner", "") ?: ""
                val street = header?.optString("street", "") ?: ""
                val barangay = header?.optString("barangay", "") ?: ""
                val city = header?.optString("city", "") ?: ""
                val province = header?.optString("province", "") ?: ""
                val tin = header?.optString("TIN", "") ?: ""
                val machineNo = header?.optString("machineNo", "") ?: ""
                val min = header?.optString("MIN", "") ?: ""

                addTextAlign(Printer.ALIGN_CENTER)
                addTextSize(2, 2)
                addText("$propertyName\n")
                addTextSize(1, 1)
                addText("$owner\n")
                addText("$street, $barangay\n")
                addText("$city, $province\n")
                addText("TIN: $tin\n")
                addText("Machine No: $machineNo | MIN: $min\n")
                addFeedLine(1)

                // --- RECEIPT DETAILS ---
                addTextAlign(Printer.ALIGN_LEFT)
                val invoiceNo = payload.optString("invoiceNo", "")
                val cashier = payload.optString("cashier", "")
                val date = payload.optString("date", "")
                val time = payload.optString("time", "")
                val tableNo = payload.optString("tableNo", "")
                val orderType = payload.optString("orderType", "")
                val guestName = payload.optString("guestName", "")


                addText("Invoice No : ${invoiceNo}\n")
                addText("Cashier    : ${cashier}\n")
                addText("Date       : $date ${time}\n")
                addText("Table No   : ${tableNo}\n")
                addText("Order Type : ${orderType}\n")
                addText("Guest Name : ${guestName}\n")
                addFeedLine(1)

                // --- ITEM LIST ---
                addTextAlign(Printer.ALIGN_LEFT)
                addText("Item                     Qty    Amount\n")
                addText("------------------------------------------\n")

                val itemsArray = payload.optJSONArray("items")
                var total = 0.0
                if (itemsArray != null) {
                    for (i in 0 until itemsArray.length()) {
                        val item = itemsArray.getJSONObject(i)
                        val name = item.optString("name", "")
                        val qty = item.optDouble("qty", 0.0)
                        val price = item.optDouble("price", 0.0)
                        val subtotal = item.optDouble("subtotal", 0.0)
                        total += subtotal
                        val line =
                            String.format("%-22s %5.2f %10.2f\n", name.take(22), qty, subtotal)
                        addText(line)
                    }
                }

                addText("------------------------------------------\n")
                addText(String.format("TOTAL:%33.2f\n", total))
                addFeedLine(1)

                // --- PAYMENT DETAILS ---
                val payments = payload.optJSONArray("payments")
                if (payments != null && payments.length() > 0) {
                    addText("PAYMENTS\n")
                    for (i in 0 until payments.length()) {
                        val payment = payments.getJSONObject(i)
                        val method = payment.optString("method", "Cash")
                        val amount = payment.optDouble("amount", 0.0)
                        addText(String.format("  %-20s %14.2f\n", method, amount))
                    }
                    addFeedLine(1)
                }

                // --- BREAKDOWN DETAILS ---
                val breakdown = payload.optJSONArray("breakdown")
                if (breakdown != null && breakdown.length() > 0) {
                    addText("BREAKDOWN\n")
                    for (i in 0 until breakdown.length()) {
                        val item = breakdown.getJSONObject(i)
                        val label = item.optString("label", "")
                        val amount = item.optDouble("amount", 0.0)
                        addText(String.format("  %-20s %14.2f\n", label, amount))
                    }
                    addFeedLine(1)
                }

                // --- CHANGE / APPROVAL INFO ---
                addText(String.format("CHANGE:%32s\n", payload.optString("change", "0.00")))
                addFeedLine(1)
                addTextAlign(Printer.ALIGN_CENTER)
                addText("Approved by: ${payload.optString("approvedBy", "")}\n")
                addText("Printed: ${payload.optString("printedDateTime", "")}\n")

                val reprint = payload.optBoolean("isReprint", false)
                if (reprint) {
                    addText("*** REPRINTED COPY ***\n")
                    addText("Reprinted by: ${payload.optString("rePrintedBy", "")}\n")
                    addText("Reprinted on: ${payload.optString("rePrintedDateTime", "")}\n")
                }

                val transNo = payload.optString("transNo", "")
                val separatorNo = payload.optString("separatorNo", "")
                val printerName = payload.optString("printerName", "")

                // --- QR CODE ---
                val qr = payload.optString("qr", "")
                if (qr.isNotEmpty()) {
                    addFeedLine(1)
                    addSymbol(
                        qr,
                        Printer.SYMBOL_QRCODE_MODEL_2,
                        Printer.LEVEL_L,
                        5, 5, 0
                    )
                }

                addFeedLine(3)
                addCut(Printer.CUT_FEED)

                sendData(Printer.PARAM_DEFAULT)

                Log.d("EpsonPrinter", "Receipt printed successfully")
            }
        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Invoice print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Invoice print exception: ${e.message}")
        }
    }

    // --- Collection Receipt ---
    fun printCollectionReceipt(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                Log.d(TAG_PRINTER, "Printing Collection Receipt...")
                // TODO: Add Epson commands for Collection Receipt
                sendData(Printer.PARAM_DEFAULT)
            }
        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Collection Receipt print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Collection Receipt print exception: ${e.message}")
        }
    }

    // --- Z Reading ---
    fun printZReading(payload: JSONObject, printer: Printer?) {
        try {
            printer?.apply {
                Log.d(TAG_PRINTER, "Printing Z Reading...")
                // TODO: Add Epson commands for Z Reading report
                sendData(Printer.PARAM_DEFAULT)
            }
        } catch (e: Epos2Exception) {
            Log.e(TAG_PRINTER, "Z Reading print error: ${e.errorStatus}")
        } catch (e: Exception) {
            Log.e(TAG_PRINTER, "Z Reading print exception: ${e.message}")
        }
    }

    /** Prints a line of '-' characters (default length = 40). */
    private fun separatorLine(length: Int = 40, char: Char = '-'): String {
        return char.toString().repeat(length.coerceAtMost(48)) + "\n"
    }

    /** Prints a line of '=' characters (default length = 40). */
    private fun separatorEqual(length: Int = 40, char: Char = '='): String {
        return char.toString().repeat(length.coerceAtMost(48)) + "\n"
    }

    /** Prints a line of '*' characters (default length = 40). */
    private fun separatorAsterisk(length: Int = 40, char: Char = '*'): String {
        return char.toString().repeat(length.coerceAtMost(48)) + "\n"
    }

    private fun formatColumnsRight(
        values: List<String>,
        lineWidth: Int = 42,
        ratios: List<Int> = emptyList()
    ): String {
        if (values.isEmpty()) return ""

        // Default ratios if none are provided
        val actualRatios = ratios.ifEmpty { List(values.size) { 1 } }

        val totalRatio = actualRatios.sum().toFloat()

        // Calculate widths based on ratios
        val widths = actualRatios.map { ((it / totalRatio) * lineWidth).toInt() }.toMutableList()

        // Fix rounding error to ensure total == lineWidth
        val diff = lineWidth - widths.sum()
        if (diff > 0) widths[widths.size - 1] += diff

        // Build formatted string
        val result = buildString {
            for (i in values.indices) {
                val value = values[i]
                val width = widths[i]
                val str = value.take(width)
                append(str.padStart(width, ' '))
            }
            append("\n")
        }

        return result
    }

    private fun formatUnderline(label: String, lineWidth: Int = 42): String {
        val prefix = "$label "
        val remaining = lineWidth - prefix.length
        val underscores = "_".repeat(maxOf(remaining, 0))
        return prefix + underscores + "\n"
    }

    /**
     * Format columns so total width == lineWidth and values don't wrap.
     * - Non-last columns: left aligned, truncated with ellipsis if needed.
     * - Last column: right aligned, if too long keeps rightmost characters (useful for prices/decimals).
     *
     * @param values  List of column texts
     * @param weights Relative width ratios for each column
     * @param lineWidth Total characters per line (default 42)
     * @return A single formatted string (with trailing newline)
     */
    private fun formatColumns(
        values: List<String>,
        weights: List<Int>,
        lineWidth: Int = 42
    ): String {
        require(values.size == weights.size) { "values and weights must have the same length" }

        val totalWeight = weights.sum().takeIf { it > 0 } ?: 1

        // Compute integer column widths
        val colWidths = weights.map { (it.toDouble() / totalWeight * lineWidth).toInt() }.toMutableList()

        // Fix rounding difference
        val diff = lineWidth - colWidths.sum()
        if (diff != 0) colWidths[colWidths.lastIndex] = colWidths.last() + diff

        // Build line
        val line = buildString {
            for (i in values.indices) {
                val value = values[i] ?: ""
                val colWidth = colWidths[i].coerceAtLeast(0)

                if (colWidth == 0) continue

                val str = when {
                    i == values.lastIndex -> { // last column: right-aligned
                        if (value.length > colWidth)
                            value.takeLast(colWidth)
                        else
                            value.padStart(colWidth, ' ')
                    }
                    else -> { // left-aligned for others
                        if (value.length > colWidth) {
                            if (colWidth > 1)
                                value.take(colWidth - 1) + "…"
                            else
                                value.take(colWidth)
                        } else {
                            value.padEnd(colWidth, ' ')
                        }
                    }
                }
                append(str)
            }
            append("\n")
        }

        return line
    }
}
