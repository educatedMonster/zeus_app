import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Border;
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../constants/app_strings.dart';

/// ---------- FILE HELPERS ----------

String _generateFilename(String selectedReport) {
  final timestamp = DateFormat('yyyy-MM-dd_HHmm').format(DateTime.now());
  return "${selectedReport.replaceAll(' ', '_')}_$timestamp";
}

/// ----- Export to Excel -----
Future<File> _exportToExcel(
    String selectedReport,
    List<Map<String, dynamic>> data,
    ) async {
  if (data.isEmpty) {
    throw Exception("No data to export.");
  }

  final excel = Excel.createExcel();
  const defaultSheetName = 'Sheet1';
  final sheetName = '$selectedReport Report';

  // Rename or use the default sheet to ensure it's saved
  excel.rename(defaultSheetName, sheetName);

  final sheet = excel[sheetName];

  // ----- Add Header Row -----
  final headers = data.first.keys.toList();
  sheet.appendRow(headers.map((e) => TextCellValue(e)).toList());

  // ----- Add Data Rows -----
  for (final row in data) {
    sheet.appendRow(
      row.values.map((v) => TextCellValue(v.toString())).toList(),
    );
  }

  // ----- Save File -----
  final bytes = excel.encode()!;
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/${_generateFilename(selectedReport)}.xlsx')
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes);

  return file;
}

/// ----- Export to Excel with Styles -----
Future<File> _exportToExcelWithStyles(
    String selectedReport,
    List<Map<String, dynamic>> data,
    ) async {
  if (data.isEmpty) {
    throw Exception("No data to export.");
  }

  final excel = Excel.createExcel();
  const defaultSheetName = 'Sheet1';
  final sheetName = '$selectedReport Report';

  // ✅ Rename default sheet instead of creating a new one
  excel.rename(defaultSheetName, sheetName);
  final sheet = excel[sheetName];

  /// ----- Header Style -----
  final headerStyle = CellStyle(
    bold: true,
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    backgroundColorHex: ExcelColor.blue,
    // Light blue header background
    fontColorHex: ExcelColor.black,
  );

  /// ----- Data Style -----
  final dataStyle = CellStyle(
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    leftBorder: Border(borderColorHex: ExcelColor.grey),
    rightBorder: Border(borderColorHex: ExcelColor.grey),
    topBorder: Border(borderColorHex: ExcelColor.grey),
    bottomBorder: Border(borderColorHex: ExcelColor.grey),
  );

  /// ----- Add Header Row -----
  final headers = data.first.keys.toList();
  sheet.appendRow(headers.map((e) => TextCellValue(e)).toList());

  // Apply header style
  for (int col = 0; col < headers.length; col++) {
    final cell = sheet.cell(
      CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0),
    );
    cell.cellStyle = headerStyle;
  }

  /// ----- Add Data Rows -----
  for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
    final row = data[rowIndex];
    for (int col = 0; col < row.values.length; col++) {
      final value = row.values.elementAt(col)?.toString() ?? '';
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex + 1),
      );
      cell.value = TextCellValue(value);
      cell.cellStyle = dataStyle;
    }
  }

  /// ----- Simulated Auto-fit Column Width -----
  // (excel package removed setColWidth(), so we store width info in metadata)
  final columnWidths = <int, double>{};
  for (int col = 0; col < headers.length; col++) {
    final maxWidth = [
      headers[col].length,
      ...data.map((row) => row.values.elementAt(col)?.toString().length ?? 0),
    ].reduce((a, b) => a > b ? a : b);
    columnWidths[col] = (maxWidth + 4).toDouble();
  }

  // NOTE: Excel doesn't use columnWidths directly in this package anymore.
  // But the above helps simulate widths if you later export via Syncfusion.

  /// ----- Save File -----
  final bytes = excel.encode()!;
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/${_generateFilename(selectedReport)}.xlsx')
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes);

  return file;
}

/// ----- Export to PDF -----
Future<File> _exportToPdf(
    String selectedReport,
    List<Map<String, dynamic>> data,
    ) async {
  if (data.isEmpty) {
    throw Exception("No data to export.");
  }

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Table.fromTextArray(
          headers: data.first.keys.toList(),
          data: data
              .map((row) => row.values.map((v) => v?.toString() ?? '').toList())
              .toList(),
        );
      },
    ),
  );

  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/${_generateFilename(selectedReport)}.pdf');
  await file.writeAsBytes(await pdf.save());
  return file;
}


/// ----- Export to PDF -----
/// 3.x and above,
// Future<File> _exportToPdf2(
//     String selectedReport,
//     List<Map<String, dynamic>> data,
//     ) async {
//   if (data.isEmpty) {
//     throw Exception("No data to export.");
//   }
//
//   final pdf = pw.Document();
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.TableHelper.fromTextArray(
//           headers: data.first.keys.toList(),
//           data: data.map((row) => row.values.toList()).toList(),
//         );
//       },
//     ),
//   );
//
//   final dir = await getTemporaryDirectory();
//   final file = File('${dir.path}/${_generateFilename(selectedReport)}.pdf');
//   await file.writeAsBytes(await pdf.save());
//   return file;
// }

/// ----- Export to CSV -----
Future<File> _exportToCsv(
  String selectedReport,
  List<Map<String, dynamic>> data,
) async {
  if (data.isEmpty) {
    throw Exception("No data to export.");
  }

  final headers = data.first.keys.toList();
  final rows = data.map((row) => row.values.toList()).toList();
  final csvData = const ListToCsvConverter().convert([headers, ...rows]);

  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/${_generateFilename(selectedReport)}.csv');
  await file.writeAsString(csvData);
  return file;
}

/// ----- Create File -----
Future<File> createFile(
  String selectedReport,
  List<Map<String, dynamic>> data,
  String selectedFormat,
) async {
  switch (selectedFormat.toUpperCase()) {
    case "EXCEL":
      return _exportToExcel(selectedReport, data);
    // return _exportToExcelWithStyles(selectedReport, data);
    case "CSV":
      return _exportToCsv(selectedReport, data);
    case "PDF":
      return _exportToPdf(selectedReport, data);
    default:
      throw Exception("Unsupported format: $selectedFormat");
  }
}

/// ----- Share File -----
Future<void> shareFile(String selectedReport, File file) async {
  final params = ShareParams(
    text: 'Exported $selectedReport Report',
    files: [XFile(file.path)],
  );

  await SharePlus.instance.share(params);
}

/// ----- Send file through mail -----
Future<void> sendMail(String selectedReport, File file, String toEmail) async {
  final smtpServer = SmtpServer(
    Constants.smtpServerName,
    port: Constants.smtpPort,
    ssl: false,
    username: Constants.smtpUsername,
    password: Constants.smtpPassword,
  );

  final message = Message()
    ..from = const Address('alerts@servoitsolutions.ph', 'Report')
    ..recipients = [toEmail]
    // ..ccRecipients = [toEmail]
    ..subject = '$selectedReport Report'
    ..text = '$selectedReport Report. Please find the attached file. '
    ..attachments = [FileAttachment(file)];

  try {
    final sendReport = await send(message, smtpServer);
    debugPrint('Message sent: $sendReport');

    await file.delete();
  } on MailerException catch (e) {
    debugPrint('Message not sent. Error: $e');
    for (var p in e.problems) {
      debugPrint('Problem: ${p.code}: ${p.msg}');
    }
  } catch (e) {
    debugPrint('Message not sent. Error: $e');
  }
}
