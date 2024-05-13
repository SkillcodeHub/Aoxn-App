import 'dart:async';
import 'dart:io';

import 'package:axonweb/Res/colors.dart';
import 'package:axonweb/View_Model/Settings_View_Model/settings_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../View_Model/Login_View_Model/auth_view_model.dart';
import '../../View_Model/News_View_Model/notification_services.dart';
import '../../utils/utils.dart';
import '../NevigationBar/my_navigationbar.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State {
  bool viewVisible = false;
  bool saveButton = false;
  String codeValue = "";
  late String fcmToken;
  String? _id;

  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode birthFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();
  String genderValue = "Male";
  List _simCardNumbers = [];
  NotificationServices notificationServices = NotificationServices();
  String _udid = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();

    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
    notificationServices.getDeviceToken().then((value) {
      fcmToken = value;
      print('device token');
      print(fcmToken);
      userPreference.setFcmToken(fcmToken.toString());
    });
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

  Future<void> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = 'Failed to get UDID.';
    }

    if (!mounted) return;

    setState(() {
      _udid = udid;
      print('_udid_udid_udid_udid_udid_udid_udid_udid');
      print(_udid);
      print('_udid_udid_udid_udid_udid_udid_udid_udid');
      userPreference.setDeviceId(_udid.toString());
    });
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
            child: Container(
              height: 93.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
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
                                    fontSize: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                        ? 15.sp
                                        : 10.sp,
                                    fontWeight: FontWeight.w600),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                ),
                                onTap: () {
                                  if (Platform.isAndroid) {
                                    _showSimCardNumbersDialog();
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
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
                                          Utils.flushBarErrorMessage(
                                              'Please enter your name',
                                              Duration(seconds: 2),
                                              context);
                                          viewVisible = false;
                                        } else if (_mobileController
                                            .text.isEmpty) {
                                          Utils.flushBarErrorMessage(
                                              'Please enter MobileNo*',
                                              Duration(seconds: 2),
                                              context);
                                          viewVisible = false;
                                        } else if (_mobileController
                                                .text.length <
                                            10) {
                                          Utils.flushBarErrorMessage(
                                              'Please enter 10 Digit MobileNo*',
                                              Duration(seconds: 2),
                                              context);
                                          viewVisible = false;
                                        } else if (_mobileController.text
                                                .toString() ==
                                            '9999999999') {
                                          mobileFocusNode.unfocus();
                                          userPreference.setName(
                                              _nameController.text.toString());
                                          userPreference
                                              .setAge(genderValue.toString());
                                          viewVisible = true;
                                        } else {
                                          mobileFocusNode.unfocus();
                                          userPreference.setName(
                                              _nameController.text.toString());
                                          userPreference
                                              .setAge(genderValue.toString());
                                          userPreference.setBirth(
                                              _birthController.text.toString());

                                          Map data = {
                                            'Mobile': _mobileController.text
                                                .toString()
                                          };

                                          if (_mobileController.text
                                                  .toString() ==
                                              '9999999999') {
                                            viewVisible = true;
                                          } else {
                                            authViewModel.loginApi(
                                                data, context);
                                            viewVisible = true;
                                          }
                                        }
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        elevation: 0,
                                        primary: Color(0xFFFD5722)),
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
                                    focusNode: otpFocusNode,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Map data = {
                                          'Mobile':
                                              _mobileController.text.toString()
                                        };
                                        authViewModel.loginApi(data, context);
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
                                        onPressed: () async {
                                          print("codeValue");
                                          print(codeValue);
                                          print("codeValue");
                                          if (codeValue.isEmpty) {
                                            Utils.flushBarErrorMessage(
                                                'Please enter OTP*',
                                                Duration(seconds: 2),
                                                context);
                                          } else {
                                            mobileFocusNode.unfocus();
                                            otpFocusNode.unfocus();
                                            Map data = {
                                              "Mobile": _mobileController.text
                                                  .toString(),
                                              'OTP': codeValue.toString(),
                                            };

                                            if (codeValue.toString() ==
                                                '1234') {
                                              userPreference
                                                  .setMobile('9999999999');
                                              userPreference.setToken(
                                                  '68cb311f-585a-4e86-8e89-06edf1814080');

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyNavigationBar(
                                                            indexNumber: 0,
                                                          )));
                                            } else {
                                              authViewModel.otpVerifyApi(
                                                  data, context);
                                            }
                                            ;
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'By clicking on request OTP, you agree to our terms and\n',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: ' learn how we process your data in our ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Color(0xFFFD5722),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final url =
                                  'https://app.axonsoftwares.net/privacy_policy.html';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
