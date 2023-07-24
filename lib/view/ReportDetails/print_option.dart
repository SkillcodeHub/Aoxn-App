// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String description =
//       "<h3 style='text-align:center;'>PRESCRIPTION</h3><span>Date: 21-Feb-2023 12:30 PM</span><br/><span style='font-weight:bold;'>Name: ANIL KHIMJIBHAI</span><br/><br/><div style='padding-bottom:5px;font-family:verdana;'><br/><span style='font-size:12px;font-weight:bold;'>Diagnosis:</span><br/><span style='font-size:12px;'>ABDOMINAL COLIC (2)\r\nABDOMINAL COLIC (2)</span><br/><br/><span style='font-size:20px;font-weight:bold;'>Rx</span><br/><div style='padding-bottom:2px;border-bottom:1px solid lightgray;'>1. SYRUP  <strong>CARMICIDE  SYRUP</strong> [DIGESTIVE SYP]<br/>5 ml 3 times  ... for 5 days</div><div style='padding-bottom:2px;border-bottom:1px solid lightgray;'><br/>2. SYRUP  <strong>RANIDOM P/RENICO</strong> [RANITIDINE]<br/>5 ml 2 times  ... for 5 days</div></div><br/><div style='font-weight:bold'>Dr. Jayesh Sonvani<br/>Consulting Neonatologist and Pediatrician<br/><br/>G 11256</div>";

//   Future<pw.Document> generatePDF() async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Center(
//             child: pw.Column(
//               children: [
//                 pw.Padding(
//                   padding: pw.EdgeInsets.all(10),
//                   child: pw.Container(
//                     child: pw.Text(
//                       description,
//                       style: pw.TextStyle(fontSize: 24.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );

//     return pdf;
//   }

//   Future<void> savePDF(pw.Document pdf) async {
//     final output = await getTemporaryDirectory();
//     final outputFile = File('${output.path}/my_document.pdf');
//     await outputFile.writeAsBytes(await pdf.save());
//     print('PDF saved to ${outputFile.path}');
//   }

//   Future<void> printPDF(pw.Document pdf) async {
//     final output = await getTemporaryDirectory();
//     final outputFile = File('${output.path}/my_document.pdf');
//     await outputFile.writeAsBytes(await pdf.save());

//     await Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async {
//         return pdf.save();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PDF Generation',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('PDF Generation'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () async {
//               final pdf = await generatePDF();
//               // Choose either savePDF or printPDF
//               // await savePDF(pdf);
//               await printPDF(pdf);
//             },
//             child: Text('Generate PDF'),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
// import 'package:path_provider/path_provider.dart';

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late String generatedPdfFilePath;

//   @override
//   void initState() {
//     super.initState();
//     generateExampleDocument();
//   }

//   Future<void> generateExampleDocument() async {
//     final htmlContent = """
//     <!DOCTYPE html>
//     <html>
//       <head>
//         <style>
//         table, th, td {
//           border: 1px solid black;
//           border-collapse: collapse;
//         }
//         th, td, p {
//           padding: 5px;
//           text-align: left;
//         }
//         </style>
//       </head>
//       <body>
//         <h2>PDF Generated with flutter_html_to_pdf plugin</h2>

//         <table style="width:100%">
//           <caption>Sample HTML Table</caption>
//           <tr>
//             <th>Month</th>
//             <th>Savings</th>
//           </tr>
//           <tr>
//             <td>January</td>
//             <td>100</td>
//           </tr>
//           <tr>
//             <td>February</td>
//             <td>50</td>
//           </tr>
//         </table>

//         <p>Image loaded from web</p>
//         <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
//       </body>
//     </html>
//     """;

//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     final targetPath = appDocDir.path;
//     final targetFileName = "example-pdf";

//     final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
//         htmlContent, targetPath, targetFileName);
//     generatedPdfFilePath = generatedPdfFile.path;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Text(generatedPdfFilePath),
//           Center(
//             child: ElevatedButton(
//               child: Text("Open Generated PDF Preview"),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => PDFViewerScaffold(appBar: AppBar(title: Text("Generated PDF Document")), path: generatedPdfFilePath)),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }

// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String description =
//       "<h3 style='text-align:center;'>PRESCRIPTION</h3><span>Date: 21-Feb-2023 12:30 PM</span><br/><span style='font-weight:bold;'>Name: ANIL KHIMJIBHAI</span><br/><br/><div style='padding-bottom:5px;font-family:verdana;'><br/><span style='font-size:12px;font-weight:bold;'>Diagnosis:</span><br/><span style='font-size:12px;'>ABDOMINAL COLIC (2)\r\nABDOMINAL COLIC (2)</span><br/><br/><span style='font-size:20px;font-weight:bold;'>Rx</span><br/><div style='padding-bottom:2px;border-bottom:1px solid lightgray;'>1. SYRUP  <strong>CARMICIDE  SYRUP</strong> [DIGESTIVE SYP]<br/>5 ml 3 times  ... for 5 days</div><div style='padding-bottom:2px;border-bottom:1px solid lightgray;'><br/>2. SYRUP  <strong>RANIDOM P/RENICO</strong> [RANITIDINE]<br/>5 ml 2 times  ... for 5 days</div></div><br/><div style='font-weight:bold'>Dr. Jayesh Sonvani<br/>Consulting Neonatologist and Pediatrician<br/><br/>G 11256</div>";

//   Future<pw.Document> generatePDF() async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Center(
//             child: pw.Column(
//               children: [
//                 pw.Padding(
//                   padding: pw.EdgeInsets.all(10),
//                   child: pw.Container(
//                     child: pw.Text(
//                       description,
//                       style: pw.TextStyle(fontSize: 24.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );

//     return pdf;
//   }

//   Future<void> savePDF(pw.Document pdf) async {
//     final output = await getTemporaryDirectory();
//     final outputFile = File('${output.path}/my_document.pdf');
//     await outputFile.writeAsBytes(await pdf.save());
//     print('PDF saved to ${outputFile.path}');
//   }

//   Future<void> printPDF(pw.Document pdf) async {
//     final output = await getTemporaryDirectory();
//     final outputFile = File('${output.path}/my_document.pdf');
//     await outputFile.writeAsBytes(await pdf.save());

//     await Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async {
//         return pdf.save();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PDF Generation',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('PDF Generation'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () async {
//               final pdf = await generatePDF();
//               // Choose either savePDF or printPDF
//               // await savePDF(pdf);
//               await printPDF(pdf);
//             },
//             child: Text('Generate PDF'),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
// import 'package:path_provider/path_provider.dart';

// import '../demo.dart';

// class html_to_pdf extends StatefulWidget {
//   const html_to_pdf({Key? key}) : super(key: key);

//   @override
//   State<html_to_pdf> createState() => _html_to_pdfState();
// }

// class _html_to_pdfState extends State<html_to_pdf> {
//   String cfData =
//       """<?xml version=\"1.0\" encoding=\"utf-16\"?>\r\n<div style=\"font-family:verdana;\">\r\n  <h3 style=\"text-align:center;\">PRESCRIPTION</h3>\r\n  <span>\r\n\t\t\t\tDate: 17-Jul-2023 01:50 PM</span>\r\n  <br />\r\n  <span style=\"font-weight:bold;\">\r\n\t\t\t\tName:   TEST</span>\r\n  <br />\r\n  <br />\r\n  <span style=\"display:block;\">\r\n    <strong>Examination: </strong>Fever Malaria</span>\r\n  <span style=\"display:block;\">\r\n    <strong>Diagnosis: </strong>MALARIA</span>\r\n  <br />\r\n  <div style=\"padding-bottom:5px;\">\r\n    <span style=\"font-size:20px;font-weight:bold;padding-bottom:20px;display:inline-block\">Rx</span>\r\n    <br />\r\n    <div style=\"margin-bottom:10px;padding-bottom:5px;border-bottom:1px solid lightgray;\">\r\n      <span style=\"font-size:100%;min-width:10px;display:inline-block;\">2.\r\n\t\t\t\t\t\t</span>\r\n      <span style=\"font-size:100%;\">Syrup</span>\r\n      <span style=\"font-size:100%;font-weight:bold;padding-left:20px;display:inline-block;\">CROCIN\r\n\t\t\t\t\t\t\t\t\t[ANTI PYRETIC]\r\n\t\t\t\t\t\t\t\t</span>\r\n      <span style=\"font-size:90%;padding-left:15px;display:block;line-height:15px\">\r\n        <br /><strong>4.8 ml</strong> in MOR at 9 am<br/>For 6 days</span>\r\n      <span style=\"font-size:90%;padding-left:15px;display:block;line-height:10px\">\r\n        <br /></span>\r\n    </div>\r\n    <div>\r\n      <strong>Advice:</strong>\r\n      <span style=\"display:block;font-size:90%;width:100%;\">fever</span>\r\n    </div>\r\n    <div style=\"display:block;margin-top:10px;\">\r\n      <strong>Remark:</strong>\r\n      <span style=\"display:block;font-size:90%;width:100%;\">Please check RX</span>\r\n    </div>\r\n    <div style=\"display:block;margin-top:10px;width:100%;\">\r\n      <strong>Follow-up: </strong>26-Jul-2023 - Wednesday</div>\r\n  </div>\r\n  <div style=\"display:block;margin-top:10px;padding-bottom:2px;border-bottom:1px solid lightgray;width:100%;\" />\r\n  <div style=\"margin-top:20px;text-align:right;width:100%;display:block;\">\r\n    <span style=\"font-size:100%;font-weight:bold;\">Dr. John Smith</span>\r\n    <br />\r\n    <span style=\"font-size:90%\">GJ-DEMO</span>\r\n    <br />\r\n    <span style=\"font-size:90%\">Consulting Pediatrician<br />MD PED</span>\r\n  </div>\r\n</div>""";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Html to Pdf"),
//       ),
//       body: Center(
//         child: Container(
//           child: ElevatedButton(
//             onPressed: () async {
//               convert(cfData, "File Name");
//               var targetPath2 =
//                   await _localPath; //  file store path is required for open the file and send to the next screen

//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CertificateDownload(
//                       certificateData: "File Name",
//                       certificatePath: targetPath2
//                           .toString(), // File name is that name that was open in next screen
//                     ),
//                   ));
//             },
//             child: Text("Html_to_pdf"),
//           ),
//         ),
//       ),
//     );
//   }

//   convert(String cfData, String name) async {
//     // Name is File Name that you want to give the file
//     var targetPath = await _localPath;
//     var targetFileName = name;

//     var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
//         cfData, targetPath!, targetFileName);
//     print(generatedPdfFile);
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(generatedPdfFile.toString()),
//     ));
//   }

//   Future<String?> get _localPath async {
//     Directory? directory;
//     try {
//       if (Platform.isIOS) {
//         directory = await getApplicationSupportDirectory();
//       } else {
//         // if platform is android
//         directory = Directory('/storage/emulated/0/Download');
//         if (!await directory.exists()) {
//           directory = await getExternalStorageDirectory();
//         }
//       }
//     } catch (err, stack) {
//       print("Can-not get download folder path");
//     }
//     return directory?.path;
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

class html_to_pdf extends StatefulWidget {
  const html_to_pdf({Key? key}) : super(key: key);

  @override
  State<html_to_pdf> createState() => _html_to_pdfState();
}

class _html_to_pdfState extends State<html_to_pdf> {
  String cfData =
      """<?xml version=\"1.0\" encoding=\"utf-16\"?>\r\n<div style=\"font-family:verdana;\">\r\n  <h3 style=\"text-align:center;\">PRESCRIPTION</h3>\r\n  <span>\r\n\t\t\t\tDate: 17-Jul-2023 01:50 PM</span>\r\n  <br />\r\n  <span style=\"font-weight:bold;\">\r\n\t\t\t\tName:   TEST</span>\r\n  <br />\r\n  <br />\r\n  <span style=\"display:block;\">\r\n    <strong>Examination: </strong>Fever Malaria</span>\r\n  <span style=\"display:block;\">\r\n    <strong>Diagnosis: </strong>MALARIA</span>\r\n  <br />\r\n  <div style=\"padding-bottom:5px;\">\r\n    <span style=\"font-size:20px;font-weight:bold;padding-bottom:20px;display:inline-block\">Rx</span>\r\n    <br />\r\n    <div style=\"margin-bottom:10px;padding-bottom:5px;border-bottom:1px solid lightgray;\">\r\n      <span style=\"font-size:100%;min-width:10px;display:inline-block;\">2.\r\n\t\t\t\t\t\t</span>\r\n      <span style=\"font-size:100%;\">Syrup</span>\r\n      <span style=\"font-size:100%;font-weight:bold;padding-left:20px;display:inline-block;\">CROCIN\r\n\t\t\t\t\t\t\t\t\t[ANTI PYRETIC]\r\n\t\t\t\t\t\t\t\t</span>\r\n      <span style=\"font-size:90%;padding-left:15px;display:block;line-height:15px\">\r\n        <br /><strong>4.8 ml</strong> in MOR at 9 am<br/>For 6 days</span>\r\n      <span style=\"font-size:90%;padding-left:15px;display:block;line-height:10px\">\r\n        <br /></span>\r\n    </div>\r\n    <div>\r\n      <strong>Advice:</strong>\r\n      <span style=\"display:block;font-size:90%;width:100%;\">fever</span>\r\n    </div>\r\n    <div style=\"display:block;margin-top:10px;\">\r\n      <strong>Remark:</strong>\r\n      <span style=\"display:block;font-size:90%;width:100%;\">Please check RX</span>\r\n    </div>\r\n    <div style=\"display:block;margin-top:10px;width:100%;\">\r\n      <strong>Follow-up: </strong>26-Jul-2023 - Wednesday</div>\r\n  </div>\r\n  <div style=\"display:block;margin-top:10px;padding-bottom:2px;border-bottom:1px solid lightgray;width:100%;\" />\r\n  <div style=\"margin-top:20px;text-align:right;width:100%;display:block;\">\r\n    <span style=\"font-size:100%;font-weight:bold;\">Dr. John Smith</span>\r\n    <br />\r\n    <span style=\"font-size:90%\">GJ-DEMO</span>\r\n    <br />\r\n    <span style=\"font-size:90%\">Consulting Pediatrician<br />MD PED</span>\r\n  </div>\r\n</div>""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Html to Pdf"),
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () async {
              await convert(cfData, "File Name");
            },
            child: Text("Html_to_pdf"),
          ),
        ),
      ),
    );
  }

  convert(String cfData, String name) async {
    // Name is File Name that you want to give the file
    var targetPath = await _localPath;
    var targetFileName = name;

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        cfData, targetPath!, targetFileName);

    // Download the PDF file
    final file = File(generatedPdfFile.path);
    final bytes = await file.readAsBytes();

    // Save the PDF file to disk
    final downloadDirectory = await _getDownloadDirectory();
    final pdfFile = File('${downloadDirectory!.path}/$name.pdf');
    await pdfFile.writeAsBytes(bytes,flush: true);


    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('PDF file downloaded'),
    ));
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
      return Directory('/storage/emulated/0/Download');
    } else {
      return await getDownloadsDirectory();
    }
  }
}
