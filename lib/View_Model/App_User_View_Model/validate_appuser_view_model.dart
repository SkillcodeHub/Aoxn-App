import 'dart:async';
import 'package:axonweb/data/response/api_response.dart';
import 'package:flutter/material.dart';

import '../../Model/ValidateAppUser_Model/validateappuser_model.dart';
import '../../Repository/AppUser_Repository/validate_appuser_repository.dart';
import '../Services/SharePreference/SharePreference.dart';

class ValidateAppUserViewmodel with ChangeNotifier {
      UserPreferences userPreference = UserPreferences();

  final _myRepo = ValidateAppUserRepository();
  ApiResponse<ValidateAppUserModel> validateAppUserData = ApiResponse.loading();
  setValidateAppUser(ApiResponse<ValidateAppUserModel> response) {
    validateAppUserData = response;
    notifyListeners();
  }

  // bool _loading = false;
  // bool get loading => _loading;

  // setLoading(bool value) {
  //   _loading = value;
  //   notifyListeners();
  // }

  Future<void> fetchValidateAppUserApi(
    String platform,
    String deviceId,
    String loginAuthToken,
  ) async {
    setValidateAppUser(ApiResponse.loading());
    _myRepo.validateAppUser(platform, deviceId, loginAuthToken).then((value) {
      setValidateAppUser(ApiResponse.completed(value));
      print('valuevaluevaluevaluevaluevaluevaluevaluevaluevaluevalue');
      print(validateAppUserData.data!.displayMessage.toString());
      print(
          'valuevaluevaluevaluevaluevaluevaluevaluevaluevaluevaluevaluevalue');
                  userPreference.setletId(validateAppUserData.data!.displayMessage.toString());

    }).onError((error, stackTrace) {
      setValidateAppUser(ApiResponse.error(error.toString()));
    });
  }
}
