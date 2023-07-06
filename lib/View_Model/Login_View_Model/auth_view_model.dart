import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Repository/Login_Repository/auth_repository.dart';
import '../../utils/utils.dart';
import '../../view/ChangeProvider/change_provider_screen.dart';
import '../App_User_View_Model/register_appuser_view_model.dart';
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

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _myRepo.loginapi(data).then((value) {
      setLoading(false);
      // final userPreference =
      //     Provider.of<GetProviderTokenViewModel>(context, listen: false);
      // userPreference.saveProviderToken(GetProviderTokenModel(
      //     displayMessage: value['displayMessage'].toString()));

      if (value['status'] == true) {
        // Utils.snackBar('OTP Send Successfully', context);

        // Timer(
        //     Duration(seconds: 2),
        //     () =>
        //         Navigator.pushNamed(context, RoutesName.otp, arguments: data));

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
    final registerAppUserViewModel =
        Provider.of<RegisterAppUserViewModel>(context, listen: false);
    UserPreferences userPreference = UserPreferences();
    dynamic otpVerifyData = {
      "Mobile": data['Mobile'].toString(),
      'OTP': data['OTP'].toString(),
    };
    dynamic registerUserData = {
      "platform": data['platform'].toString(),
      'deviceId': data['deviceId'].toString(),
      'fullName': data['fullName'].toString(),
      'mobile': data['mobile'].toString(),
      'fcmToken': data['fcmToken'].toString(),
      'gender': data['gender'].toString(),
      'userType': data['userType'].toString(),
      'birthDate': data['birthDate'].toString(),
    };
    print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
    print(data['platform']);
    print(data['deviceId']);
    print(data['fullName']);
    print(data['mobile']);
    print(data['fcmToken']);
    print(data['gender']);
    print(data['userType']);
    print(data['birthDate']);
    print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
    setSignUpLoading(true);
    _myRepo.otpverifyapi(otpVerifyData).then((value) {
      setSignUpLoading(false);
      // Utils.flushBarErrorMessage(
      //     'Otp is Valid'.toString(), Duration(seconds: 5), context);

      if (value['status'] == true) {
        Utils.snackBar('Otp is Valid', context);
        userPreference.setMobile(data['Mobile']);

        Timer(
            Duration(seconds: 2),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeProviderScreen())));
        registerAppUserViewModel.registerAppUserApi(registerUserData, context);
        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        Utils.snackBar('OTP is not valid*', context);
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
