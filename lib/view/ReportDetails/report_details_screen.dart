import 'dart:io';
import 'dart:math';

import 'package:axonweb/View/ReportDetails/print_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

class ReportDetailsScreen extends StatefulWidget {
  final dynamic reportDetails;
  const ReportDetailsScreen({super.key, required this.reportDetails});

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  String? cfData;

  void downloadPdf() async {
    String name = "RXreport"; // Replace this with the desired base file name

    // Append the file index to the name to make each file unique

    try {
      String? targetPath = await _localPath;
      if (targetPath == null) {
        print("Error: Local path is null.");
        return;
      }

      var currentTime = DateTime.now().millisecondsSinceEpoch;
      DateTime now = DateTime.now();

      String timeFormatted = DateFormat('HH:mm:ss').format(now);

      var random = Random().nextInt(10000);
      String fileName = '$name-${timeFormatted}.pdf';

      var targetFileName = '$fileName-$currentTime-$random';

      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        cfData!,
        targetPath,
        targetFileName,
      );

      if (generatedPdfFile == null) {
        print("Error: Failed to generate PDF file.");
        return;
      }

      final file = File(generatedPdfFile.path);
      if (!file.existsSync()) {
        print("Error: Target file does not exist.");
        return;
      }

      final bytes = await file.readAsBytes();

      // Save the PDF file to disk
      final downloadDirectory = await _getDownloadDirectory();
      if (downloadDirectory != null) {
        final pdfFile = File('${downloadDirectory.path}/$fileName');
        if (!pdfFile.parent.existsSync()) {
          pdfFile.parent.createSync(
              recursive:
                  true); // Create the parent directory if it doesn't exist
        }
        await pdfFile.writeAsBytes(bytes);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF file downloaded'),
          ),
        );
      }
    } catch (e) {
      print("Error while generating or downloading the PDF file: $e");
    }
  }

  Future<String?> get _localPath async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationSupportDirectory();
      } else {
        // if platform is android
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      print("Can-not get download folder path");
    }
    return directory?.path;
  }

  Future<Directory?> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    } else {
      print("Error: Unsupported platform.");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    cfData = widget.reportDetails['treatment'].toString();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: SizerUtil.deviceType == DeviceType.mobile
            ? Size.fromHeight(7.h)
            : Size.fromHeight(5.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: IconButton(
              iconSize: SizerUtil.deviceType == DeviceType.mobile ? 2.5.h : 3.h,
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Report Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (Platform.isIOS) {
                      downloadPdf();
                    } else {
                      await generateAndSavePdf(cfData!, 'RXhistory', context);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                    height: 27,
                    child: Image.asset('images/pdf.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Doctor:' +
                                widget.reportDetails['providerName'].toString(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Member: ' +
                                widget.reportDetails['patientName'].toString(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Updated on: ' +
                                    widget.reportDetails['date'].toString(),
                              ),
                              InkWell(
                                child: Container(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Html(
                            data: widget.reportDetails['treatment'].toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
