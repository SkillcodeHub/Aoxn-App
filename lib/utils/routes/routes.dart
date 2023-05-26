import 'package:axonweb/utils/routes/routes_name.dart';
import 'package:axonweb/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../view/login/login_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());
      // case RoutesName.signUp:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => SignUpView());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
