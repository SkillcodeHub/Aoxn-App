import 'package:axonweb/Utils/routes/routes_name.dart';
import 'package:axonweb/View/NewsDetails/news_details_screen.dart';
import 'package:axonweb/View/ReportDetails/report_details_screen.dart';
import 'package:axonweb/View/SelectAppointmentDate/selectappointmentdate_screen.dart';

import 'package:axonweb/View/Settings/settings_screen.dart';
import 'package:axonweb/view/Book/book_appointment_screen.dart';
import 'package:axonweb/view/ChangeProvider/change_provider_screen.dart';
import 'package:axonweb/view/Event/event_screen.dart';
import 'package:axonweb/view/News/news_screen.dart';
import 'package:axonweb/view/otp/otp_verifyscreen.dart';
import 'package:axonweb/view/report/report_screen.dart';
import 'package:axonweb/view/Splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../View/NevigationBar/my_navigationbar.dart';
import '../../View/SelectPateint/selectpateint_screen.dart';
import '../../view/Login/login_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());
      case RoutesName.otp:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                OtpVerifyScreen(mobile: settings.arguments as Map));
      case RoutesName.changeProvider:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChangeProviderScreen());
      case RoutesName.myNevigationBar:
        return MaterialPageRoute(
            builder: (BuildContext context) => MyNavigationBar());
      case RoutesName.news:
        return MaterialPageRoute(
            builder: (BuildContext context) => NewsScreen());
      case RoutesName.newsdetails:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                NewsDetailsScreen(data: settings.arguments as Map));
      case RoutesName.book:
        return MaterialPageRoute(
            builder: (BuildContext context) => BookApointmentScreen());
      case RoutesName.event:
        return MaterialPageRoute(
            builder: (BuildContext context) => EventScreen());
      case RoutesName.report:
        return MaterialPageRoute(
            builder: (BuildContext context) => ReportScreen());
      case RoutesName.settings:
        return MaterialPageRoute(
            builder: (BuildContext context) => SettingsScreen());
      case RoutesName.reportDetails:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ReportDetailsScreen(reportDetails: settings.arguments as Map));
      case RoutesName.selectAppointmentDate:
        return MaterialPageRoute(
            builder: (BuildContext context) => SelectAppointmentDateScreen(
                selectedDocotrId: settings.arguments as Map));
      case RoutesName.selectPatient:
        return MaterialPageRoute(
            builder: (BuildContext context) => SelectPatientScreen());
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
