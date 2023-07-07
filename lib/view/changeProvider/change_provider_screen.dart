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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../Res/colors.dart';
import '../../View_Model/App_User_View_Model/register_appuser_view_model.dart';
import '../../View_Model/ChangeProvider_View_Model/provider_view_model.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';
import '../NevigationBar/my_navigationbar.dart';
import '../QR_Code/qr_code_screen.dart';

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
  String? token;
  String getKeyForCallLetId = 'false';
  String? customerName;
  String? appCode;
  String showAlertDialog = ' ';

  @override
  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
        print(token);
      });
    });
    // userPreference.getKeyForCallLetIdApi().then((value) {
    //   setState(() {
    //     getKeyForCallLetId = value!;
    //     print(getKeyForCallLetId);
    //   });
    // });
    super.initState();
    // fetchData();
    setState(() {
      print(showAlertDialog);
      if (showAlertDialog != ' ') {
        _showBackAlertDialog();
      } else {}
    });
    fetchData1();
    retrieveUserData();
    
  }

  Future<List<String>> fetchData() async {
    List<String> retrievedList =
        await userPreference.getListFromSharedPreferences();
    return retrievedList;
  }

  // Future _qrScanner() async {
  //   var camaraStatus = await Permission.camera.status;
  //   if (camaraStatus.isGranted) {
  //     String? qrdata = '';

  //     //  await scanner.scan();
  //     print('--------------------------------------------------------------');
  //     // print(qrdata);
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
  //       String? qrdata = '';

  //       // await scanner.scan();
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

  Future<List<Map<String, dynamic>>?> fetchData1() async {
    List<Map<String, dynamic>>? storedData =
        await userPreference.getDataFromSharedPreferences();
    return storedData;
  }
  late Map<String, dynamic> userData = {};

Future<void> retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      setState(() {
        userData = jsonDecode(userDataString);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
print('userData');
print(userData);
print('userData');


// Map registerUserData = {
//   "platform": "Mobile",
//                                         "deviceId": '134DF283-87B1-498A-B07C-7BE43F9E9D21',
//                                         "fullName":
//                                            'parth',
//                                         "mobile":
//                                             '9316019087',
//                                         "fcmToken": 'dwIUvw3_JEmMsTFaFhsG6B:APA91bHeqG_PLSnfojV9vyVF2eyZ9oWeeeqwCnTYkRSeUDDDv63hn3oL6VszRi2D0kMEsNCkAgoNnj0LAUW3QUV-ripWc3ZBlpf_MqzgbJAX3scbvz1jwjeOdQzbzq8EGiQD124texQ8',
//                                         "gender": 'Male',
//                                         "userType": '1',
//                                         "birthDate":
//                                             '',};
// final registerAppUserViewModel =
      //   Provider.of<RegisterAppUserViewModel>(context, listen: false);

      //    Timer(Duration(microseconds: 20), () {
      // if (userData != {} && getKeyForCallLetId == 'false' ){
       

      //   registerAppUserViewModel.registerAppUserApi(userData, context);
      // userPreference.setKeyForCallLetIdApi('true');
        
        
// }
    // });

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
          print('providerList');
          print(providerList);

          String specificToken = token.toString();

          Map<String, dynamic>? specificHospital;
          int? specificHospitalIndex;

          for (int i = 0; i < providerList.length; i++) {
            if (providerList[i]["token"] == specificToken) {
              specificHospital = providerList[i];
              specificHospitalIndex = i;
              break;
            }
          }

          if (specificHospital != null && specificHospitalIndex != null) {
            providerList.removeAt(specificHospitalIndex);
            providerList.insert(0, specificHospital);
          }

// Print the updated list

          List<Map<String, dynamic>> outputList = [];

          for (var hospital in providerList) {
            Map<String, dynamic> output = {
              "doctorName": hospital["doctorName"],
              "token": hospital["token"]
            };
            outputList.add(output);
          }

          print(outputList);

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
                                          _navigateAppcodeAndHospitalName(
                                              context);
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
                                            width: 38.w,
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
                              outputList.length != 0
                                  ? Text(
                                      'OR',
                                      style: TextStyle(fontSize: 12.sp),
                                    )
                                  : Container(),
                              SizedBox(height: 1.h),
                              SizedBox(
                                height: 41.h,
                                child: outputList.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: outputList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              // showBackAlertDialog() {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content: Text(
                                                      'Are you sure want to change your current Provider?',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text(
                                                          'CANCEL',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text(
                                                          'CONFIRM',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        onPressed: () {
                                                          final token =
                                                              outputList[index]
                                                                      ['token']
                                                                  .toString();

                                                          print(
                                                              outputList[index]
                                                                      ['token']
                                                                  .toString());
                                                          userPreference
                                                              .setToken(token);

                                                          // customerTkenViewmodel
                                                          //     .fetchCustomerTokenApi(
                                                          //         context,
                                                          //         providerList[index]['token']
                                                          //             .toString());
                                                          Timer(
                                                              Duration(
                                                                  seconds: 1),
                                                              () => Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              MyNavigationBar())));
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              // }

                                              // final token = outputList[index]
                                              //         ['token']
                                              //     .toString();

                                              // print(outputList[index]['token']
                                              //     .toString());
                                              // userPreference.setToken(token);

                                              // // customerTkenViewmodel
                                              // //     .fetchCustomerTokenApi(
                                              // //         context,
                                              // //         providerList[index]['token']
                                              // //             .toString());
                                              // Timer(
                                              //     Duration(seconds: 1),
                                              //     () => Navigator.push(
                                              //         context,
                                              //         MaterialPageRoute(
                                              //             builder: (context) =>
                                              //                 MyNavigationBar())));
                                            },
                                            child: Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      outputList[index]
                                                              ['doctorName']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    token ==
                                                            outputList[index]
                                                                    ['token']
                                                                .toString()
                                                        ? Image.asset(
                                                            'images/true.png',
                                                            height: 13,
                                                          )
                                                        : Container()
                                                  ],
                                                ),
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
                                            _navigateAppcodeAndHospitalName(
                                                context);
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
                                              width: 38.w,
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

  _navigateAppcodeAndHospitalName(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRScannerWidget()),
    );
    print(result[0]);
    print(result[1]);

    if (result != null) {
      setState(() {
        customerName = result[0];
        appCode = result[1];
        showAlertDialog = result[2];
      });
      setState(() {
        print('showAlertDialogshowAlertDialogshowAlertDialogshowAlertDialog');
        print(showAlertDialog);
        print('showAlertDialogshowAlertDialogshowAlertDialogshowAlertDialog');
        if (showAlertDialog != ' ') {
          _showBackAlertDialog();
        }
      });
      // if (result[2] == true) {
      //   setState(() {
      //     showAlertDialog = true;
      //   });
      // }
    }
  }

  void _showBackAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Confirm',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            customerName.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'CANCEL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: Text(
                'CONFIRM',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                customerTokenByQRViewmodel.fetchCustomerTokenByQR(
                  context,
                  appCode.toString(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
