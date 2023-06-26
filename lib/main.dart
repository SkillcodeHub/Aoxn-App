import 'package:axonweb/View_Model/Book_View_Model/Book_view_Model.dart';
import 'package:axonweb/res/colors.dart';
import 'package:axonweb/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'Provider/current_time_provider.dart';
import 'View_Model/Book_View_Model/bookAppointment_view_model.dart';
import 'View_Model/Book_View_Model/cancelAppointment_view_model.dart';
import 'View_Model/Event_View_Model/event_view_model.dart';
import 'View_Model/Login_View_Model/auth_view_model.dart';
import 'View_Model/News_View_Model/news_view_model.dart';
import 'View_Model/SelectPateint_View_Model/getPatientByMobileNo_view_model.dart';
import 'View_Model/SelectPateint_View_Model/selectPateintById_view_model.dart';
import 'View_Model/Settings_View_Model/settings_view_model.dart';
import 'utils/routes/routes_name.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => TimeProvider()),
        // ChangeNotifierProvider(create: (_) => GetProviderTokenViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewmodel()),
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
      ],
      child: Sizer(builder: (context, orientation, DeviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: AppPrimaryColor,
          ),
          // home: ViewWidget(),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
        );
      }),
    );
  }
}
