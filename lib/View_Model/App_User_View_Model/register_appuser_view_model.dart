import 'dart:async';
import 'package:axonweb/View_Model/App_User_View_Model/validate_appuser_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import '../../Repository/AppUser_Repository/register_appuser_repository.dart';
import '../../Utils/utils.dart';

class RegisterAppUserViewModel with ChangeNotifier {
  final _myRepo = RegisterAppUserRepository();

  // bool _loading = false;
  // bool get loading => _loading;
  // setLoading(bool value) {
  //   _loading = value;
  //   notifyListeners();
  // }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setisLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> registerAppUserApi(dynamic data, BuildContext context) async {
    // Get device id
    // String? result = await PlatformDeviceId.getDeviceId;

    final validateAppUserViewmodel =
        Provider.of<ValidateAppUserViewmodel>(context, listen: false);
    print('registerUserDataregisterUserDataregisterUserData');
    print(data);
    print('registerUserDataregisterUserDataregisterUserData');
    setisLoading(true);
    _myRepo.registerAppUserApi(data).then((value) {
      setisLoading(false);
      // Utils.flushBarErrorMessage(
      //     'Otp is Valid'.toString(), Duration(seconds: 5), context);
      if (value['status'] == true) {
        // Utils.snackBar(value['messageCode'], context);
        print(value);
        String platform = 'Mobile';
        String deviceId = data['deviceId'];
        // String deviceId = "134DF283-87B1-498A-B07C-7BE43F9E9D21";

        String loginAuthToken = value['displayMessage'];
        print('platform');
        print(platform);
        print(deviceId);
        print(loginAuthToken);
        print('platform');

        validateAppUserViewmodel.fetchValidateAppUserApi(
            platform, deviceId, loginAuthToken);
        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        // Utils.snackBar(value['displayMessage'], context);
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
