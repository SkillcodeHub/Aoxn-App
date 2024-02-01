import 'package:axonweb/Provider/backButton_provider.dart';
import 'package:axonweb/Utils/routes/routes_name.dart';
import 'package:axonweb/View_Model/Book_View_Model/Book_view_Model.dart';
import 'package:axonweb/View_Model/Payment_View_Model/paymentHistory_view_model.dart';
import 'package:axonweb/res/colors.dart';
import 'package:axonweb/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Provider/current_time_provider.dart';
import 'View_Model/App_User_View_Model/register_appuser_view_model.dart';
import 'View_Model/App_User_View_Model/validate_appuser_view_model.dart';
import 'View_Model/Book_View_Model/bookAppointment_view_model.dart';
import 'View_Model/Book_View_Model/cancelAppointment_view_model.dart';
import 'View_Model/Event_View_Model/event_view_model.dart';
import 'View_Model/Login_View_Model/auth_view_model.dart';
import 'View_Model/News_View_Model/news_view_model.dart';
import 'View_Model/Report_View_Model/report_view_model.dart';
import 'View_Model/SelectPateint_View_Model/getPatientByMobileNo_view_model.dart';
import 'View_Model/SelectPateint_View_Model/selectPateintById_view_model.dart';
import 'View_Model/Settings_View_Model/settings_view_model.dart';

class ContainerSizeNotifier extends ChangeNotifier {
  double width = 500;
  double height = 850;

  void toggleSize() {
    if (width == 500 && height == 850) {
      width = 650;
      height = double.infinity;
    } else {
      width = 500;
      height = 850;
    }

    notifyListeners();
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContainerSizeNotifier()),
        ChangeNotifierProvider(create: (_) => ButtonProvider()),
        ChangeNotifierProvider(create: (_) => DoctorNameProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => TimeProvider()),
        // ChangeNotifierProvider(create: (_) => GetProviderTokenViewModel()),
        // ChangeNotifierProvider(create: (_) => NewsViewmodel()),
        ChangeNotifierProvider<NewsViewmodel>.value(value: NewsViewmodel()),
        ChangeNotifierProvider<DoctorListViewmodel>.value(
            value: DoctorListViewmodel()),
        ChangeNotifierProvider<SettingsViewModel>.value(
            value: SettingsViewModel()),
        ChangeNotifierProvider<GetPatientByMobileListViewmodel>.value(
            value: GetPatientByMobileListViewmodel()),
        ChangeNotifierProvider<SelectPatientByIdViewmodel>.value(
            value: SelectPatientByIdViewmodel()),
        ChangeNotifierProvider<BookAppointmentViewModel>.value(
            value: BookAppointmentViewModel()),
        ChangeNotifierProvider<EventListViewmodel>.value(
            value: EventListViewmodel()),
        ChangeNotifierProvider<CancelAppointmentViewModel>.value(
            value: CancelAppointmentViewModel()),
        ChangeNotifierProvider<RegisterAppUserViewModel>.value(
            value: RegisterAppUserViewModel()),
        ChangeNotifierProvider<ValidateAppUserViewmodel>.value(
            value: ValidateAppUserViewmodel()),
        ChangeNotifierProvider<ReportViewmodel>.value(value: ReportViewmodel()),
        ChangeNotifierProvider<PaymentHistoryViewmodel>.value(
            value: PaymentHistoryViewmodel()),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        bool isTablet = constraints.maxWidth > 600;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: isTablet ? _buildTabletLayout(context) : _buildMobileLayout(),
        );
      }),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Stack(
      children: [
        Container(
          // color: Colors.grey.shade100,
          child: Center(
            child: Consumer<ContainerSizeNotifier>(
              builder: (context, containerSize, _) {
                return Container(
                  width: containerSize.width,
                  height: containerSize.height,
                  child: Builder(
                    builder: (context) {
                      return Sizer(
                        builder: (context, orientation, deviceType) {
                          return MaterialApp(
                            debugShowCheckedModeBanner: false,
                            title: 'Flutter Demo',
                            theme: ThemeData(
                              primarySwatch: AppPrimaryColor,
                            ),
                            // home: SplashScreen(
                            //   indexNumber: 0,
                            // ),
                            initialRoute: RoutesName.splash,
                            onGenerateRoute: Routes.generateRoute,
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          // top: 10,
          bottom: 16.0,
          right: 16.0,
          child: Container(
            height: 60,
            width: 60,
            child: ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey.shade800),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              onPressed: () {
                Provider.of<ContainerSizeNotifier>(context, listen: false)
                    .toggleSize();
              },
              child: Consumer<ContainerSizeNotifier>(
                builder: (context, containerSize, _) {
                  return Image.asset(containerSize.width == 500
                      ? 'images/full_screen.png'
                      : 'images/minimize_screen.png');

                  //  Text(
                  //   containerSize.width == 500 ? 'Zoom In' : 'Zoom Out',
                  // );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Consumer<ContainerSizeNotifier>(
      builder: (context, containerSize, _) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: AppPrimaryColor,
              ),
              // home: SplashScreen(
              //   indexNumber: 0,
              // ),
              initialRoute: RoutesName.splash,
              onGenerateRoute: Routes.generateRoute,
            );
          },
        );
      },
    );
  }
}



// export PATH="$PATH:/Users/dweeppatel/Documents/FlutterDev/sdk/flutter/bin"





// class MyApp extends StatelessWidget {
//   int indexNumber = 0;
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ButtonProvider()),
//         ChangeNotifierProvider(create: (_) => DoctorNameProvider()),

//         ChangeNotifierProvider(create: (_) => AuthViewModel()),
//         ChangeNotifierProvider(create: (_) => TimeProvider()),
//         // ChangeNotifierProvider(create: (_) => GetProviderTokenViewModel()),
//         // ChangeNotifierProvider(create: (_) => NewsViewmodel()),
//         ChangeNotifierProvider<NewsViewmodel>.value(value: NewsViewmodel()),
//         ChangeNotifierProvider<DoctorListViewmodel>.value(
//             value: DoctorListViewmodel()),
//         ChangeNotifierProvider<SettingsViewModel>.value(
//             value: SettingsViewModel()),
//         ChangeNotifierProvider<GetPatientByMobileListViewmodel>.value(
//             value: GetPatientByMobileListViewmodel()),
//         ChangeNotifierProvider<SelectPatientByIdViewmodel>.value(
//             value: SelectPatientByIdViewmodel()),
//         ChangeNotifierProvider<BookAppointmentViewModel>.value(
//             value: BookAppointmentViewModel()),
//         ChangeNotifierProvider<EventListViewmodel>.value(
//             value: EventListViewmodel()),
//         ChangeNotifierProvider<CancelAppointmentViewModel>.value(
//             value: CancelAppointmentViewModel()),
//         ChangeNotifierProvider<RegisterAppUserViewModel>.value(
//             value: RegisterAppUserViewModel()),
//         ChangeNotifierProvider<ValidateAppUserViewmodel>.value(
//             value: ValidateAppUserViewmodel()),
//         ChangeNotifierProvider<ReportViewmodel>.value(value: ReportViewmodel()),
//         ChangeNotifierProvider<PaymentHistoryViewmodel>.value(
//             value: PaymentHistoryViewmodel()),
//       ],
//       child: Sizer(builder: (context, orientation, DeviceType) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: AppPrimaryColor,
//           ),
//           // home: SplashScreen(
//           //   indexNumber: 0,
//           // ),
//           initialRoute: RoutesName.splash,
//           onGenerateRoute: Routes.generateRoute,
//         );
//       }),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   int indexNumber = 0;
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ButtonProvider()),
//         ChangeNotifierProvider(create: (_) => DoctorNameProvider()),

//         ChangeNotifierProvider(create: (_) => AuthViewModel()),
//         ChangeNotifierProvider(create: (_) => TimeProvider()),
//         // ChangeNotifierProvider(create: (_) => GetProviderTokenViewModel()),
//         // ChangeNotifierProvider(create: (_) => NewsViewmodel()),
//         ChangeNotifierProvider<NewsViewmodel>.value(value: NewsViewmodel()),
//         ChangeNotifierProvider<DoctorListViewmodel>.value(
//             value: DoctorListViewmodel()),
//         ChangeNotifierProvider<SettingsViewModel>.value(
//             value: SettingsViewModel()),
//         ChangeNotifierProvider<GetPatientByMobileListViewmodel>.value(
//             value: GetPatientByMobileListViewmodel()),
//         ChangeNotifierProvider<SelectPatientByIdViewmodel>.value(
//             value: SelectPatientByIdViewmodel()),
//         ChangeNotifierProvider<BookAppointmentViewModel>.value(
//             value: BookAppointmentViewModel()),
//         ChangeNotifierProvider<EventListViewmodel>.value(
//             value: EventListViewmodel()),
//         ChangeNotifierProvider<CancelAppointmentViewModel>.value(
//             value: CancelAppointmentViewModel()),
//         ChangeNotifierProvider<RegisterAppUserViewModel>.value(
//             value: RegisterAppUserViewModel()),
//         ChangeNotifierProvider<ValidateAppUserViewmodel>.value(
//             value: ValidateAppUserViewmodel()),
//         ChangeNotifierProvider<ReportViewmodel>.value(value: ReportViewmodel()),
//         ChangeNotifierProvider<PaymentHistoryViewmodel>.value(
//             value: PaymentHistoryViewmodel()),
//       ],
//       child: Sizer(builder: (context, orientation, DeviceType) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: AppPrimaryColor,
//           ),
//           // home: SplashScreen(
//           //   indexNumber: 0,
//           // ),
//           initialRoute: RoutesName.splash,
//           onGenerateRoute: Routes.generateRoute,
//         );
//       }),
//     );
//   }
// }

