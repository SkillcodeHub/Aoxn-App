import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../Repository/Login_Repository/auth_repository.dart';
import '../../utils/utils.dart';
import '../../view/ChangeProvider/change_provider_screen.dart';
import '../Services/SharePreference/SharePreference.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  static void flushBarErrorMessagelogin(
      String message, Duration duration, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        duration: duration,
        borderRadius: BorderRadius.circular(20),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: Colors.grey.shade800,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _myRepo.loginapi(data).then((value) {
      setLoading(false);

      if (value['status'] == true) {
        flushBarErrorMessagelogin(
            'OTP is sent on given mobile, Valid for 30 minutes.'.toString(),
            Duration(seconds: 5),
            context);
        if (kDebugMode) {
          print(value.toString());
        }
      }
      ;
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(
          error.toString(), Duration(seconds: 3), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> otpVerifyApi(dynamic data, BuildContext context) async {
    UserPreferences userPreference = UserPreferences();
    dynamic otpVerifyData = {
      "Mobile": data['Mobile'].toString(),
      'OTP': data['OTP'].toString(),
    };

    setSignUpLoading(true);
    _myRepo.otpverifyapi(otpVerifyData).then((value) {
      setSignUpLoading(false);

      if (value['status'] == true) {
        // Utils.snackBar('Otp is Valid', context);
        Utils.flushBarErrorMessage(
            'Otp is Valid', Duration(seconds: 2), context);

        userPreference.setMobile(data['Mobile']);
        Timer(
            Duration(seconds: 0),
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ChangeProviderScreen()),
                (route) => false));
        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        Utils.flushBarErrorMessage(
            'OTP is not valid*', Duration(seconds: 2), context);

        // Utils.snackBar('OTP is not valid*', context);
        if (kDebugMode) {
          print(value.toString());
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(
            error.toString(), Duration(seconds: 3), context);
        print(error.toString());
      }
    });
  }
}
