// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:sms_autofill/sms_autofill.dart';

// import '../../View_Model/Login_View_Model/auth_view_model.dart';
// import '../../utils/utils.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool viewVisible = false;
//   String codeValue = "";

//   TextEditingController _mobileController = TextEditingController();
//   FocusNode mobileFocusNode = FocusNode();

//   void showWidget() {
//     setState(() {
//       viewVisible = true;
//     });
//   }

//   void hideWidget() {
//     setState(() {
//       viewVisible = false;
//     });
//   }

//   void showWidget1() {
//     setState(() {
//       if (_mobileController.text.isEmpty) {
//         Utils.snackBar('Please enter MobileNo*', context);
//       } else if (_mobileController.text.length < 10) {
//         Utils.snackBar('Please enter 10 Digit MobileNo*', context);
//       } else {
//         showWidget;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = Provider.of<AuthViewModel>(context);
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Container(
//                   height: 200,
//                   child: Image.asset(
//                     'images/axon.png',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: _mobileController,
//                           keyboardType: TextInputType.number,
//                           focusNode: mobileFocusNode,
//                           decoration: InputDecoration(
//                             hintText: 'Mobile Number(10 digit)',
//                             labelText: 'Mobile',
//                             // prefixIcon: Icon(Icons.alternate_email),
//                           ),
//                           // onFieldSubmitted: (value) {
//                           //   Utils.fieldFocusChange(
//                           //       context, emailFocusNode, passwordFocusNode);
//                           // },
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                                 //   width: 60.w,
//                                 ),
//                             TextButton(
//                               child: Text(
//                                 'Request OTP',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               onPressed: () {
//                                 if (_mobileController.text.isEmpty) {
//                                   Utils.snackBar(
//                                       'Please enter MobileNo*', context);
//                                 } else if (_mobileController.text.length < 10) {
//                                   Utils.snackBar(
//                                       'Please enter 10 Digit MobileNo*',
//                                       context);
//                                 } else if (_mobileController.text.length > 10) {
//                                   Utils.snackBar(
//                                       'Please enter 10 Digit MobileNo*',
//                                       context);
//                                 } else {
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) =>
//                                   //             OtpVerifyScreen()));
//                                   Map data = {
//                                     'Mobile': _mobileController.text.toString()
//                                   };
//                                   // authViewModel.loginApi(data, context);
//                                   // Timer(Duration(seconds: 5), () {
//                                   //   _mobileController.clear();
//                                   // });

//                                   // showWidget1;
//                                 }
//                               },
//                               // showWidget,
//                               style: TextButton.styleFrom(
//                                   elevation: 0, primary: Color(0xFFFD5722)),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Visibility(
//                   maintainSize: true,
//                   maintainAnimation: true,
//                   maintainState: true,
//                   visible: viewVisible,
//                   child: Card(
//                     color: Colors.amber,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Center(
//                             child: PinFieldAutoFill(
//                               currentCode: codeValue,
//                               codeLength: 4,
//                               onCodeChanged: (code) {
//                                 print("onCodeChanged $code");
//                                 setState(() {
//                                   codeValue = code.toString();
//                                 });
//                               },
//                               onCodeSubmitted: (val) {
//                                 print("onCodeSubmitted $val");
//                               },
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   // listenOtp
//                                 },
//                                 child: const Text(
//                                   "Resend",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                               TextButton(
//                                   onPressed: () {
//                                     print("codeValue");
//                                     print(codeValue);
//                                     print("codeValue");
//                                     // _verifyOTP();
//                                   },
//                                   child: const Text(
//                                     "Verify OTP",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   )),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'package:axonweb/Res/colors.dart';
import 'package:axonweb/View_Model/Settings_View_Model/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:mobile_number/mobile_number.dart';
import '../../View_Model/Login_View_Model/auth_view_model.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State {
  bool viewVisible = false;
  bool saveButton = false;
  String codeValue = "";

  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode birthFocusNode = FocusNode();
  String genderValue = "Male";
  List _simCardNumbers = [];
  // TextEditingController _phoneNumberController = TextEditingController();
  // NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
    // notificationServices.requestNotificationPermission();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      List<SimCard>? simCards = await MobileNumber.getSimCards;
      _simCardNumbers = simCards!.map((sim) => sim.number).toList();
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  Widget buildCard(String simCardNumber) {
    return InkWell(
      onTap: () {
        _selectPhoneNumber(simCardNumber);
      },
      child: Container(
        height: 7.h,
        margin: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              height: 4.h,
              child: Image.asset('images/phone.png'),
            ),
            Text('  ' + simCardNumber),
          ],
        ),
      ),
    );
  }

  void _showSimCardNumbersDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Continue with',
            style: TextStyle(fontSize: 16),
          ),
          content: ListView.builder(
            shrinkWrap: true,
            itemCount: _simCardNumbers.length,
            itemBuilder: (BuildContext context, int index) {
              return buildCard(_simCardNumbers[index]);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('NONE OF THE ABOVE'),
            ),
          ],
        );
      },
    );
  }

  void _selectPhoneNumber(String phoneNumber) {
    setState(() {
      _mobileController.text = phoneNumber;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                // SizedBox(
                //   height: 10.h,
                // ),
                Container(
                  height: 11.h,
                  child: Image.asset(
                    'images/axon.png',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login with your details',
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          focusNode: nameFocusNode,
                          decoration: InputDecoration(
                            // hintText: 'Mobile Number(10 digit)',
                            labelText: 'Full Name',
                          ),
                        ),
                        TextFormField(
                          controller: _birthController,
                          keyboardType: TextInputType.text,
                          focusNode: birthFocusNode,
                          decoration: InputDecoration(
                            // hintText: 'Mobile Number(10 digit)',
                            labelText: 'Birthday(Optional)',
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: 'Male',
                                          activeColor: Color(0xFFFD5722),
                                          groupValue: genderValue,
                                          onChanged: (value) {
                                            setState(() {
                                              genderValue = value!;
                                            });
                                          },
                                        ),
                                        Container(
                                          child: Text(
                                            "Male",
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: 'Female',
                                          activeColor: Color(0xFFFD5722),
                                          groupValue: genderValue,
                                          onChanged: (value) {
                                            setState(() {
                                              genderValue = value!;
                                            });
                                          },
                                        ),
                                        Container(
                                          child: Text(
                                            "Female",
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                //   width: 60.w,
                                ),
                            // TextButton(
                            //   child: Text(
                            //     'save',
                            //     style: TextStyle(
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            //   onPressed: () {
                            //     setState(() {
                            //       if (_nameController.text.isEmpty) {
                            //         Utils.snackBar(
                            //             'Please enter Name*', context);
                            //       } else {
                            //         saveButton = true;
                            //       }
                            //     });
                            //   },
                            //   style: TextButton.styleFrom(
                            //       elevation: 0, primary: Color(0xFFFD5722)),
                            // ),
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
                      children: [
                        TextFormField(
                          controller: _mobileController,
                          keyboardType: TextInputType.number,
                          focusNode: mobileFocusNode,
                          decoration: InputDecoration(
                            hintText: 'Mobile Number(10 digit)',
                            labelText: 'Mobile',
                            // prefixIcon: Icon(Icons.alternate_email),
                          ),

                          onTap: () {
                            if (Platform.isAndroid) {
                              _showSimCardNumbersDialog();
                            }
                          },
                          // onFieldSubmitted: (value) {
                          //   Utils.fieldFocusChange(
                          //       context, emailFocusNode, passwordFocusNode);
                          // },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                //   width: 60.w,
                                ),
                            TextButton(
                              child: Text(
                                'Request OTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_nameController.text.isEmpty) {
                                    Utils.snackBar(
                                        'Please enter your name', context);
                                    viewVisible = false;
                                  } else if (_mobileController.text.isEmpty) {
                                    Utils.snackBar(
                                        'Please enter MobileNo*', context);
                                    viewVisible = false;
                                  } else if (_mobileController.text.length <
                                      10) {
                                    Utils.snackBar(
                                        'Please enter 10 Digit MobileNo*',
                                        context);
                                    viewVisible = false;
                                  }

                                  // else if (_mobileController.text.length >
                                  //     10) {
                                  //   Utils.snackBar(
                                  //       'Please enter 10 Digit MobileNo*',
                                  //       context);
                                  //   viewVisible = false;
                                  // }
                                  else {
                                    mobileFocusNode.unfocus();
                                    userPreference.setName(
                                        _nameController.text.toString());
                                    userPreference
                                        .setAge(genderValue.toString());
                                    Map data = {
                                      'Mobile':
                                          _mobileController.text.toString()
                                    };
                                    authViewModel.loginApi(data, context);
                                    // Timer(Duration(seconds: 5), () {
                                    //   _mobileController.clear();
                                    // });
                                    viewVisible = true;

                                    // Close the keyboard
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                  elevation: 0, primary: Color(0xFFFD5722)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewVisible,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                            child: PinFieldAutoFill(
                              currentCode: codeValue,
                              codeLength: 4,
                              onCodeChanged: (code) {
                                print("onCodeChanged $code");
                                setState(() {
                                  codeValue = code.toString();
                                });
                              },
                              onCodeSubmitted: (val) {
                                print("onCodeSubmitted $val");
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Map data = {
                                    'Mobile': _mobileController.text.toString()
                                  };
                                  authViewModel.loginApi(data, context);
                                  // Timer(Duration(seconds: 5), () {
                                  //   _mobileController.clear();
                                  // });
                                  viewVisible = true;
                                },
                                child: const Text(
                                  "Resend",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    print("codeValue");
                                    print(codeValue);
                                    print("codeValue");
                                    // _verifyOTP();
                                    if (codeValue.isEmpty) {
                                      Utils.snackBar(
                                          'Please enter OTP*', context);
                                    } else {
                                      Map data = {
                                        "Mobile":
                                            _mobileController.text.toString(),
                                        'OTP': codeValue.toString()
                                      };
                                      authViewModel.otpVerifyApi(data, context);
                                    }
                                  },
                                  child: const Text(
                                    "Verify OTP",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
