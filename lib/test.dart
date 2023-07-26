// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:math';

// // convert(String cfData, String name) async {
// Future<void> generateAndSavePdf(
//     String cfData, String name, BuildContext context) async {
//   var targetPath = await _localPath;
//   if (targetPath == null) {
//     print("Error: Local path is null.");
//     return;
//   }

//   var currentTime = DateTime.now().second;
//   var random = Random().nextInt(10000);
//   var targetFileName = '$name-$currentTime-$random';

//   var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
//       cfData, targetPath, targetFileName);

//   if (generatedPdfFile == null) {
//     print("Error: Failed to generate PDF file.");
//     return;
//   }

//   // Check if the target directory exists before writing the file
//   final file = File(generatedPdfFile.path);
//   if (!file.existsSync()) {
//     print("Error: Target directory does not exist.");
//     return;
//   }

//   final bytes = await file.readAsBytes();

//   // Save the PDF file to disk
//   final downloadDirectory = await _getDownloadDirectory();
//   final pdfFile = File('${downloadDirectory!.path}/$name.pdf');
//   await pdfFile.writeAsBytes(bytes);

//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     content: Text('PDF file downloaded'),
//   ));
// }

// Future<String?> get _localPath async {
//   Directory? directory;
//   try {
//     if (Platform.isIOS) {
//       directory = await getApplicationSupportDirectory();
//     } else {
//       // if platform is android
//       directory = Directory('/storage/emulated/0/Download');
//       if (!await directory.exists()) {
//         directory = await getExternalStorageDirectory();
//       }
//     }
//   } catch (err, stack) {
//     print("Can-not get download folder path");
//   }
//   return directory?.path;
// }

// Future<Directory?> _getDownloadDirectory() async {
//   if (Platform.isAndroid) {
//     return Directory('/storage/emulated/0/Download');
//   } else {
//     return await getDownloadsDirectory();
//   }
// }
