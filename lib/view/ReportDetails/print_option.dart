// import 'dart:io';

// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';
// import 'package:pdf/widgets.dart' as pw;

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String discription = Bidi.stripHtmlIfNeeded(
//       "<h3 style='text-align:center;'>PRESCRIPTION</h3><span>Date: 21-Feb-2023 12:30 PM</span><br/><span style='font-weight:bold;'>Name: ANIL KHIMJIBHAI</span><br/><br/><div style='padding-bottom:5px;font-family:verdana;'><br/><span style='font-size:12px;font-weight:bold;'>Diagnosis:</span><br/><span style='font-size:12px;'>ABDOMINAL COLIC (2)\r\nABDOMINAL COLIC (2)</span><br/><br/><span style='font-size:20px;font-weight:bold;'>Rx</span><br/><div style='padding-bottom:2px;border-bottom:1px solid lightgray;'>1. SYRUP  <strong>CARMICIDE  SYRUP</strong> [DIGESTIVE SYP]<br/>5 ml 3 times  ... for 5 days</div><div style='padding-bottom:2px;border-bottom:1px solid lightgray;'><br/>2. SYRUP  <strong>RANIDOM P/RENICO</strong> [RANITIDINE]<br/>5 ml 2 times  ... for 5 days</div></div><br/><div style='font-weight:bold'>Dr. Jayesh Sonvani<br/>Consulting Neonatologist and Pediatrician<br/><br/>G 11256</div>");
//   String discription1 =
//       "<h3 style='text-align:center;'>PRESCRIPTION</h3><span>Date: 21-Feb-2023 12:30 PM</span><br/><span style='font-weight:bold;'>Name: ANIL KHIMJIBHAI</span><br/><br/><div style='padding-bottom:5px;font-family:verdana;'><br/><span style='font-size:12px;font-weight:bold;'>Diagnosis:</span><br/><span style='font-size:12px;'>ABDOMINAL COLIC (2)\r\nABDOMINAL COLIC (2)</span><br/><br/><span style='font-size:20px;font-weight:bold;'>Rx</span><br/><div style='padding-bottom:2px;border-bottom:1px solid lightgray;'>1. SYRUP  <strong>CARMICIDE  SYRUP</strong> [DIGESTIVE SYP]<br/>5 ml 3 times  ... for 5 days</div><div style='padding-bottom:2px;border-bottom:1px solid lightgray;'><br/>2. SYRUP  <strong>RANIDOM P/RENICO</strong> [RANITIDINE]<br/>5 ml 2 times  ... for 5 days</div></div><br/><div style='font-weight:bold'>Dr. Jayesh Sonvani<br/>Consulting Neonatologist and Pediatrician<br/><br/>G 11256</div>";

//   Future<pw.Document> generatePDF() async {
//     print(discription);
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Center(
//             child: pw.Text(discription, style: pw.TextStyle(fontSize: 24.0)),
//           );
//         },
//       ),
//     );

//     return pdf;
//   }

//   // Future<pw.Document> generatePDF1() async {
//   //   final pdf = pw.Document();

//   //   pdf.addPage(
//   //     pw.Page(
//   //       build: (pw.Context context) {
//   //         return pw.Center(
//   //           child: pw.Padding(
//   //             padding: pw.EdgeInsets.all(10),
//   //             child: pw.Container(
//   //               child: pw.Html(
//   //                 data: discription,
//   //               ),
//   //             ),
//   //           ),
//   //         );
//   //       },
//   //     ),
//   //   );

//     Future<void> savePDF(pw.Document pdf) async {
//       final output = await getTemporaryDirectory();
//       final outputFile = File('${output.path}/my_document.pdf');
//       await outputFile.writeAsBytes(await pdf.save());
//       print('PDF saved to ${outputFile.path}');
//     }

//     Future<void> printPDF(pw.Document pdf) async {
//       await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => pdf.save(),
//       );
//     }

//     return pdf;
//   }

//   Future<void> HtmlFormate(pw.Document pdf) async {
//     await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
//               format: format,
//               html: discription,
//             ));
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
//               await HtmlFormate(pdf);
//             },
//             child: Text('Generate PDF'),
//           ),
//         ),
//       ),
//     );
//   }
// }
