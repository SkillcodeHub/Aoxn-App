// import 'package:flutter/material.dart';
// import '../../Res/colors.dart';
// import '../../View_Model/News_View_Model/news_view_model.dart';
// import '../../view_model/services/SharePreference/SharePreference.dart';

// class ChangeProviderScreen extends StatefulWidget {
//   const ChangeProviderScreen({super.key});

//   @override
//   State<ChangeProviderScreen> createState() => _ChangeProviderScreenState();
// }

// class _ChangeProviderScreenState extends State<ChangeProviderScreen> {
//   final FocusNode _nodeAppcode = FocusNode();
//   TextEditingController strAppcode = TextEditingController();
//   UserPreferences userPreference = UserPreferences();
//   late String mobile;
//   CustomerTkenViewmodel customerTkenViewmodel = CustomerTkenViewmodel();
//   List<String> providerList = [];
//   @override
//   void initState() {
//     setState(() {
//       main();
//     });
//     // _newsRepository.fetchCustomerToken();
//     super.initState();
//   }

//   void main() async {
//     // Retrieve the list
//     List<String> retrievedList =
//         await userPreference.getListFromSharedPreferences();
//     print('Retrieved list from SharedPreferences:');
//     print(retrievedList);
//     providerList = retrievedList;
//     print('providerList');
//     print(providerList);
//     print('providerList');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: BackgroundColor,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: false,
//           elevation: 0,
//           backgroundColor: Color(0xffffffff),
//           leading: Padding(
//             padding: EdgeInsets.only(top: 20),
//             child: IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.arrow_back_rounded),
//             ),
//           ),
//           title: Padding(
//             padding: EdgeInsets.only(
//               top: 16.0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Change Provider",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 25,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Card(
//                     elevation: 3,
//                     // color: Colors.amber,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 100,
//                             child: Image(image: AssetImage('images/axon.png')),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Select Hospital by: ',
//                               style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           InkWell(
//                             onTap: () {
//                               // _qrScanner();
//                             },
//                             child: Row(
//                               children: [
//                                 SizedBox(width: 10),
//                                 Container(
//                                   height: 40,
//                                   child: Image(
//                                       image: AssetImage('images/axon.png')),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'SCANNING APP CODE',
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Container(
//                                 height: 1,
//                                 width: 132,
//                                 color: Colors.black,
//                               ),
//                               SizedBox(width: 5),
//                               Text('or'),
//                               SizedBox(width: 5),
//                               Container(
//                                 height: 1,
//                                 width: 164,
//                                 color: Colors.black,
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           InkWell(
//                             onTap: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return Container(
//                                       child: AlertDialog(
//                                         title: Text('Code'),
//                                         content: TextField(
//                                           focusNode: _nodeAppcode,
//                                           controller: strAppcode,
//                                           cursorColor: Color(0xFFFD5722),
//                                           onChanged: (value) {},
//                                           decoration: InputDecoration(
//                                               hintText: 'Write App Code'),
//                                         ),
//                                         actions: [
//                                           TextButton(
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Text(
//                                                 'Cancel',
//                                                 style: TextStyle(
//                                                     color: Color(0xFFFD5722)),
//                                               )),
//                                           TextButton(
//                                               onPressed: () {
//                                                 customerTkenViewmodel
//                                                     .fetchCustomerTokenApi(
//                                                         context,
//                                                         strAppcode.text
//                                                             .toString());
//                                               },
//                                               child: Text(
//                                                 'OK',
//                                                 style: TextStyle(
//                                                     color: Color(0xFFFD5722)),
//                                               ))
//                                         ],
//                                       ),
//                                     );
//                                   });
//                             },
//                             child: Row(
//                               children: [
//                                 SizedBox(width: 10),
//                                 Container(
//                                   height: 40,
//                                   child: Image(
//                                       image: AssetImage('images/axon.png')),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'WRITING CODE MANUALLY',
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'OR',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 10),
//                   Card(
//                       elevation: 3,
//                       // shape: ,
//                       child: providerList.length != 0
//                           ? ListView.builder(
//                               itemCount: providerList.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return ListTile(
//                                   title: Text('data'
//                                       // providerList[index].toString()
//                                       ),
//                                 );
//                               },
//                             )
//                           : CircularProgressIndicator()),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import '../../Res/colors.dart';
import '../../View_Model/ChangeProvider_View_Model/provider_view_model.dart';
import '../../View_Model/News_View_Model/news_view_model.dart';
import '../../demo2.dart';
import '../../view_model/services/SharePreference/SharePreference.dart';
import '../NevigationBar/my_navigationbar.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qr_code_scanner/qr_code_scanner.dart';
class ChangeProviderScreen extends StatefulWidget {
  const ChangeProviderScreen({Key? key}) : super(key: key);

  @override
  State<ChangeProviderScreen> createState() => _ChangeProviderScreenState();
}

class _ChangeProviderScreenState extends State<ChangeProviderScreen> {
  final FocusNode _nodeAppcode = FocusNode();
  TextEditingController strAppcode = TextEditingController();
  UserPreferences userPreference = UserPreferences();
  late String mobile;
  CustomerTkenViewmodel customerTkenViewmodel = CustomerTkenViewmodel();
  CustomerTokenByQRViewmodel customerTokenByQRViewmodel =
      CustomerTokenByQRViewmodel();
        var getResult = 'QR Code Result';

  @override
  void initState() {
    super.initState();
    // fetchData();
    fetchData1();
  }

  Future<List<String>> fetchData() async {
    List<String> retrievedList =
        await userPreference.getListFromSharedPreferences();
    return retrievedList;
  }

// _qrScanner(){

//   // QrImage(data: 'This is a simple QR code',
//   // version: QrVersions.auto,
//   // size: 320,
//   // gapless: false,);
// }


//   Future _qr()async{
    
//         var camaraStatus = await Permission.camera.status;
//  if (camaraStatus.isGranted) {MobileScanner(onDetect: (capture) {
//           final List<Barcode> barcodes = capture.barcodes;
//           final Uint8List? image = capture.image;
//           for (final barcode in barcodes) {
//             debugPrint('Barcode found! ${barcode.rawValue}');
//           }
//         }
//         );
//         }else{
//           var isGrant = await Permission.camera.request();

//         if (isGrant.isGranted) {MobileScanner(onDetect: (capture) {
//           final List<Barcode> barcodes = capture.barcodes;
//           final Uint8List? image = capture.image;
//           for (final barcode in barcodes) {
//             debugPrint('Barcode found! ${barcode.rawValue}');
//           }
//         }
//         );
//         }
// }
    
//     }
  // Future _qrScanner() async {
  //   var camaraStatus = await Permission.camera.status;
  //   if (camaraStatus.isGranted) {
  //     String? qrdata = await scanner.scan();
  //     print('--------------------------------------------------------------');
  //     print(qrdata);
  //     print(
  //         'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  //     Codec<String, String> stringToBase64 = utf8.fuse(base64);
  //     String decoded = stringToBase64.decode(qrdata!); // username:password
  //     print(decoded);
  //     Map<String, dynamic> jsonMap = jsonDecode(decoded.toString());

  //     String customerName = jsonMap['CustomerName'];
  //     String appCode = jsonMap['AppCode'];

  //     print('CustomerName: $customerName');
  //     print('AppCode: $appCode');
  //     print('cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
  //     print(appCode);
  //     customerTokenByQRViewmodel.fetchCustomerTokenByQR(
  //         context, appCode.toString());
  //     print(
  //         'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

  //     print('-------------------------------------------------------------');
  //   } else {
  //     var isGrant = await Permission.camera.request();

  //     if (isGrant.isGranted) {
  //       String? qrdata = await scanner.scan();
  //       print('--------------------------------------------------------------');
  //       print(qrdata);
  //       print(
  //           'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  //       Codec<String, String> stringToBase64 = utf8.fuse(base64);
  //       String decoded = stringToBase64.decode(qrdata!); // username:password
  //       print(decoded);
  //       Map<String, dynamic> jsonMap = jsonDecode(decoded.toString());

  //       String customerName = jsonMap['CustomerName'];
  //       String appCode = jsonMap['AppCode'];

  //       print('CustomerName: $customerName');
  //       print('AppCode: $appCode');
  //       print('cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
  //       print(appCode);
  //       customerTokenByQRViewmodel.fetchCustomerTokenByQR(
  //           context, appCode.toString());
  //       print(
  //           'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  //       print('--------------------------------------------------------------');
  //     }
  //   }
  // }
// void scanQRCode() async {
//     try{
//       final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);

//       if (!mounted) return;

//       setState(() {
//         getResult = qrCode;
//       });
//       print("QRCode_Result:--");
//       print(qrCode);
//     } on PlatformException {
//       getResult = 'Failed to scan QR Code.';
//     }

//   }

// final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       // Handle the scanned QR code data
//       print(scanData.code);
//       // You can perform further actions with the scanned data
//     });
//   }




  Future<List<Map<String, dynamic>>?> fetchData1() async {
    List<Map<String, dynamic>>? storedData =
        await userPreference.getDataFromSharedPreferences();
    return storedData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      // future: fetchData(),
      future: fetchData1(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error loading data from SharedPreferences'),
            ),
          );
        } else {
          List<Map<String, dynamic>> providerList = snapshot.data ?? [];

          return Scaffold(
            backgroundColor: BackgroundColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: false,
                elevation: 0,
                backgroundColor: Color(0xffffffff),
                leading: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: IconButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_rounded),
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Change Provider",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: providerList.length != 0
                ? Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.0))),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 11.h,
                                        child: Image(
                                            image: AssetImage(
                                                'images/doctor.png')),
                                      ),
                                      SizedBox(height: 1.h),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Select Hospital by: ',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      InkWell(
                                        onTap: () {
                                          // _qrScanner();
                                          // _qr();
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>QRScannerWidget()));
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(width: 2.w),
                                            Container(
                                              height: 5.h,
                                              child: Image(
                                                  image: AssetImage(
                                                      'images/qr.png')),
                                            ),
                                            SizedBox(width: 4.w),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'SCANNING APP CODE',
                                                style:
                                                    TextStyle(fontSize: 15.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: 1.h),
                                      Row(
                                        children: [
                                          Container(
                                            height: 1,
                                            width: 40.w,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 2.w),
                                          Text('or'),
                                          SizedBox(width: 2.w),
                                          Container(
                                            height: 1,
                                            width: 39.w,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                      // SizedBox(height: 1.h),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  child: AlertDialog(
                                                    title: Text('Code'),
                                                    content: TextField(
                                                      focusNode: _nodeAppcode,
                                                      controller: strAppcode,
                                                      cursorColor:
                                                          Color(0xFFFD5722),
                                                      onChanged: (value) {},
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              'Write App Code'),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFFFD5722)),
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            customerTkenViewmodel
                                                                .fetchCustomerTokenApi(
                                                                    context,
                                                                    strAppcode
                                                                        .text
                                                                        .toString());
                                                          },
                                                          child: Text(
                                                            'OK',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFFFD5722)),
                                                          ))
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(width: 2.w),
                                            Container(
                                              height: 5.h,
                                              child: Image(
                                                  image: AssetImage(
                                                      'images/keyboard.png')),
                                            ),
                                            SizedBox(width: 4.w),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'WRITING CODE MANUALLY',
                                                style:
                                                    TextStyle(fontSize: 15.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: 1.h),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              providerList.length != 0
                                  ? Text(
                                      'OR',
                                      style: TextStyle(fontSize: 12.sp),
                                    )
                                  : Container(),
                              SizedBox(height: 1.h),
                              SizedBox(
                                height: 41.h,
                                child: providerList.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: providerList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              final token = providerList[index]
                                                      ['token']
                                                  .toString();

                                              print(providerList[index]['token']
                                                  .toString());
                                              userPreference.setToken(token);

                                              // customerTkenViewmodel
                                              //     .fetchCustomerTokenApi(
                                              //         context,
                                              //         providerList[index]['token']
                                              //             .toString());
                                              Timer(
                                                  Duration(seconds: 1),
                                                  () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyNavigationBar())));
                                            },
                                            child: Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(providerList[index]
                                                        ['doctorName']
                                                    .toString()),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Container(),
                              ),
                              Text(
                                'Contact your provider for App Code',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Center(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0))),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 11.h,
                                          child: Image(
                                              image: AssetImage(
                                                  'images/doctor.png')),
                                        ),
                                        SizedBox(height: 1.h),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Select Hospital by: ',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        InkWell(
                                          onTap: () {
                                            // _qrScanner();
                                            // _qr();
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>QRScannerWidget()));
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(width: 2.w),
                                              Container(
                                                height: 5.h,
                                                child: Image(
                                                    image: AssetImage(
                                                        'images/qr.png')),
                                              ),
                                              SizedBox(width: 4.w),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'SCANNING APP CODE',
                                                  style: TextStyle(
                                                      fontSize: 15.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(height: 1.h),
                                        Row(
                                          children: [
                                            Container(
                                              height: 1,
                                              width: 40.w,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: 2.w),
                                            Text('or'),
                                            SizedBox(width: 2.w),
                                            Container(
                                              height: 1,
                                              width: 40.w,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 1.h),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    child: AlertDialog(
                                                      title: Text('Code'),
                                                      content: TextField(
                                                        focusNode: _nodeAppcode,
                                                        controller: strAppcode,
                                                        cursorColor:
                                                            Color(0xFFFD5722),
                                                        onChanged: (value) {},
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                'Write App Code'),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFFFD5722)),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              customerTkenViewmodel
                                                                  .fetchCustomerTokenApi(
                                                                      context,
                                                                      strAppcode
                                                                          .text
                                                                          .toString());
                                                            },
                                                            child: Text(
                                                              'OK',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFFFD5722)),
                                                            ))
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(width: 2.w),
                                              Container(
                                                height: 5.h,
                                                child: Image(
                                                    image: AssetImage(
                                                        'images/keyboard.png')),
                                              ),
                                              SizedBox(width: 4.w),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'WRITING CODE MANUALLY',
                                                  style: TextStyle(
                                                      fontSize: 15.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(height: 1.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              // Text(
                              //   'Contact your provider for App Code',
                              //   style: TextStyle(fontSize: 12.sp),
                              // ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }
      },
    );
  }
}

// class QRScannerWidget extends StatefulWidget {
//   @override
//   _QRScannerWidgetState createState() => _QRScannerWidgetState();
// }

// class _QRScannerWidgetState extends State<QRScannerWidget> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       // Handle the scanned QR code data
//       print(scanData.code);
//       // You can perform further actions with the scanned data
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QR Code Scanner'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 4,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: Text('Scan QR code'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
