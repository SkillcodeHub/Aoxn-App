import 'package:axonweb/View_Model/News_View_Model/notification_services.dart';
import 'package:axonweb/view/ChangeProvider/change_provider_screen.dart';
import 'package:axonweb/view/Login/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../View/NevigationBar/my_navigationbar.dart';
import '../SharePreference/SharePreference.dart';

// class SplashServices {
//   Future<GetProviderTokenModel> getProviderData() =>
//       GetProviderTokenViewModel().getProviderToken();
//   void checkAuthentication(BuildContext context) async {
//     getProviderData().then((value) async {
//       print(value.displayMessage.toString());

//       if (value.displayMessage == 'null' ||
//           value.displayMessage.toString() == '') {
//         Future.delayed(Duration(seconds: 1));
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => LoginScreen()));
//       } else {
//         await Future.delayed(Duration(seconds: 1));
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => ChangeProviderScreen()));
//       }
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }
// }

class SplashServices {
  var mobile;
  var token;
  UserPreferences userPreference = UserPreferences();
  Future getProviderData() => userPreference.getToken();
  void checkAuthentication(BuildContext context) async {
    userPreference.getMobile().then((value) {
      mobile = value;
      print('mobilemobilemobilemobilemobilemobile');
      print(mobile);
    });
    getProviderData().then((value1) async {
      token = value1;
      print('tokentokentokentokentokentokentoken');
      if (mobile == null && token == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      } else if (mobile != null && token == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ChangeProviderScreen()),
            (route) => false);
      } else if (mobile != null && token != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MyNavigationBar(
                      indexNumber: 0,
                    )),
            (route) => false);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

// class SplashServices {}
