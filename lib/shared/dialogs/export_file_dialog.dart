import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/utils/export_file_helper.dart';
import '../viewmodels/file_format_dropdown_view_model.dart';
import '../viewmodels/report_type_dropdown_view_model.dart';

class ExportFileDialog extends StatelessWidget {
  const ExportFileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(
      text: "kervinjumar.kj@gmail.com",
    );

    final List<Map<String, dynamic>> sampleData = [
      {
        "Name": "Kervin Jumar Lopez",
        "Time In": "8:00 AM",
        "Time Out": "5:00 PM",
      },
      {"Name": "Kerwin Joe Perez", "Time In": "8:00 AM", "Time Out": "5:00 PM"},
      {"Name": "John Leo Laurden", "Time In": "8:00 AM", "Time Out": "5:00 PM"},
    ];

    List<String> reportTypes = [
      "Early Birds",
      "Attendance Summary",
      "Late Comers",
    ];
    List<String> fileFormats = ["PDF", "EXCEL", "CSV"];

    String selectedReport = '';
    String selectedFormat = '';

    ReportTypeDropdownViewModel reportTypeDropdownViewModel = context
        .read<ReportTypeDropdownViewModel>();
    FileFormatDropdownViewModel fileFormatDropdownViewModel = context
        .read<FileFormatDropdownViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      reportTypeDropdownViewModel.setSelectedReport(reportTypes[0]);
      fileFormatDropdownViewModel.setSelectedFormat(fileFormats[0]);
    });

    selectedReport = reportTypeDropdownViewModel.selectedReport;
    selectedFormat = fileFormatDropdownViewModel.selectedFormat;

    return DraggableScrollableSheet(
      initialChildSize: 0.50,
      minChildSize: 0.45,
      maxChildSize: 0.95,
      expand: false,
      builder: (bc, scrollController) {
        final (:report) = bc
            .select<ReportTypeDropdownViewModel, ({String report})>(
              (cm) => (report: cm.selectedReport),
            );
        selectedReport = report;

        final (:format) = bc
            .select<FileFormatDropdownViewModel, ({String format})>(
              (cm) => (format: cm.selectedFormat),
            );
        selectedFormat = format;

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16.0.r,
                    children: [
                      // drag handle
                      Center(
                        child: Container(
                          width: 40.0.r,
                          height: 4.0.r,
                          margin: const EdgeInsets.only(bottom: 16.0).r,
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(4.0.r),
                          ),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16.0.r,
                        children: [
                          Text(
                            "Export Report",
                            style: TextStyle(
                              fontSize: 18.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          DropdownButtonFormField<String>(
                            initialValue: selectedReport,
                            decoration: const InputDecoration(
                              labelText: "Report",
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            items: reportTypes
                                .map(
                                  (r) => DropdownMenuItem(
                                    value: r,
                                    child: Text(r),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              bc
                                  .read<ReportTypeDropdownViewModel>()
                                  .setSelectedReport(val!);
                            },
                          ),

                          DropdownButtonFormField<String>(
                            initialValue: selectedFormat,
                            decoration: const InputDecoration(
                              labelText: "Format",
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            items: fileFormats
                                .map(
                                  (f) => DropdownMenuItem(
                                    value: f,
                                    child: Text(f),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              bc
                                  .read<FileFormatDropdownViewModel>()
                                  .setSelectedFormat(val!);
                            },
                          ),

                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: "Email Address",
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),

                          Visibility(
                            visible: false,
                            child: Row(
                              spacing: 8.0.r,
                              children: [
                                /// SHARE
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      final file = await createFile(
                                        selectedReport,
                                        sampleData,
                                        selectedFormat,
                                      );
                                      await shareFile(selectedReport, file);

                                      Navigator.pop(bc);
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.0.r,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 16.0,
                                      ).r,
                                    ),
                                    child: Text(
                                      "Share",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12.0.sp,
                                      ),
                                    ),
                                  ),
                                ),

                                /// MAIL
                                Expanded(
                                  child: ElevatedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.indigo,
                                      ),
                                      backgroundColor: Colors.indigo,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.0.r,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 16.0,
                                      ).r,
                                    ),
                                    onPressed: () async {
                                      final file = await createFile(
                                        selectedReport,
                                        sampleData,
                                        selectedFormat,
                                      );
                                      await sendMail(
                                        selectedReport,
                                        file,
                                        emailController.text,
                                      );

                                      Navigator.pop(bc);
                                    },
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ).copyWith(bottom: 24.0).r,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.indigo),
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0.r),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 16.0,
                          ).r,
                        ),
                        onPressed: () async {
                          final file = await createFile(
                            selectedReport,
                            sampleData,
                            selectedFormat,
                          );
                          await sendMail(
                            selectedReport,
                            file,
                            emailController.text,
                          );

                          Navigator.pop(bc);
                        },
                        child: Text(
                          "Export",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Visibility(
                visible: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ).copyWith(bottom: 24.0).r,
                  child: Column(
                    spacing: 8.0.r,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.router.maybePop();
                              },
                              label: const Text(
                                'Close',
                                style: TextStyle(color: Colors.black87),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 16.0,
                                ).r,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1.0.r,
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
