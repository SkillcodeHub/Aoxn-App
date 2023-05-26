import 'package:axonweb/Repository/Post_Repository/auth_repository.dart';
import 'package:axonweb/view/otp/otp_verifyscreen.dart';
import 'package:axonweb/view_model/provider_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/provider_model.dart';
import '../utils/utils.dart';
import '../view/changeProvider/change_provider_screen.dart';

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
    _myRepo.loginapi(data).then((value) {
      setLoading(false);
      final userPreference =
          Provider.of<GetProviderTokenViewModel>(context, listen: false);
      userPreference.saveProviderToken(GetProviderTokenModel(
          displayMessage: value['displayMessage'].toString()));
      if (kDebugMode) {
        Utils.flushBarErrorMessage('Login Successfully'.toString(), context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OtpVerifyScreen()));

        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> otpVerifyApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _myRepo.otpverifyapi(data).then((value) {
      setSignUpLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage('Otp Successfully'.toString(), context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChangeProviderScreen()));

        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
