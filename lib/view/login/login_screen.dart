import 'package:axonweb/view/otp/otp_verifyscreen.dart';
import 'package:axonweb/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool viewVisible = false;
  String codeValue = "";

  TextEditingController _mobileController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  void showWidget1() {
    setState(() {
      if (_mobileController.text.isEmpty) {
        Utils.snackBar('Please enter MobileNo*', context);
      } else if (_mobileController.text.length < 10) {
        Utils.snackBar('Please enter 10 Digit MobileNo*', context);
      } else {
        showWidget;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'images/axon.jpg',
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
                          // onFieldSubmitted: (value) {
                          //   Utils.fieldFocusChange(
                          //       context, emailFocusNode, passwordFocusNode);
                          // },
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 60.w,
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
                                if (_mobileController.text.isEmpty) {
                                  Utils.snackBar(
                                      'Please enter MobileNo*', context);
                                } else if (_mobileController.text.length < 10) {
                                  Utils.snackBar(
                                      'Please enter 10 Digit MobileNo*',
                                      context);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OtpVerifyScreen()));
                                  Map data = {
                                    'Mobile': _mobileController.text.toString()
                                  };
                                  authViewModel.loginApi(data, context);
                                }
                              },
                              // showWidget,
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
                  height: 10.h,
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
                                  // listenOtp
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
