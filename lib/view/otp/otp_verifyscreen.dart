import 'package:axonweb/view/ChangeProvider/change_provider_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../View_Model/Login_View_Model/auth_view_model.dart';
import '../../utils/utils.dart';

class OtpVerifyScreen extends StatefulWidget {
  final dynamic mobile;

  const OtpVerifyScreen({super.key, required this.mobile});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  String codeValue = "";

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(widget.mobile['Mobile'].toString()),
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
                                if (codeValue.isEmpty) {
                                  Utils.snackBar('Please enter OTP*', context);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeProviderScreen()));
                                  Map data = {
                                    "Mobile": '6353335967',
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
    );
  }
}
