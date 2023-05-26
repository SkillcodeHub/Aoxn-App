import 'package:axonweb/view/changeProvider/change_provider_screen.dart';
import 'package:axonweb/view/login/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../Model/provider_model.dart';
import '../provider_view_model.dart';

class SplashServices {
  Future<GetProviderTokenModel> getProviderData() =>
      GetProviderTokenViewModel().getProviderToken();
  void checkAuthentication(BuildContext context) async {
    getProviderData().then((value) async {
      print(value.displayMessage.toString());

      if (value.displayMessage == 'null' ||
          value.displayMessage.toString() == '') {
        Future.delayed(Duration(seconds: 1));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        await Future.delayed(Duration(seconds: 1));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChangeProviderScreen()));
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
