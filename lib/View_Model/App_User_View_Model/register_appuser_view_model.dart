import 'dart:async';

import 'package:axonweb/View_Model/App_User_View_Model/validate_appuser_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Repository/AppUser_Repository/register_appuser_repository.dart';
import '../../Utils/utils.dart';

class RegisterAppUserViewModel with ChangeNotifier {
  final _myRepo = RegisterAppUserRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setisLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> registerAppUserApi(dynamic data, BuildContext context) async {
    final validateAppUserViewmodel =
        Provider.of<ValidateAppUserViewmodel>(context, listen: false);
    setisLoading(true);
    _myRepo.registerAppUserApi(data).then((value) {
      setisLoading(false);
      if (value['status'] == true) {
        String platform = 'Mobile';
        String deviceId = data['deviceId'];

        String loginAuthToken = value['displayMessage'];

        validateAppUserViewmodel.fetchValidateAppUserApi(
            platform, deviceId, loginAuthToken);
        if (kDebugMode) {
          print(value.toString());
        }
      } else {
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
