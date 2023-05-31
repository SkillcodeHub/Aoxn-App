import 'package:axonweb/res/colors.dart';
import 'package:axonweb/utils/routes/routes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Model/DoctorList_Model/doctorlist_model.dart';
import 'Model/NewsDetails_Model/newsdetails_model.dart';
import 'View_Model/ChangeProvider_View_Model/provider_view_model.dart';
import 'View_Model/Login_View_Model/auth_view_model.dart';
import 'View_Model/News_View_Model/news_view_model.dart';
import 'View_Model/Settings_View_Model/settings_view_model.dart';
import 'utils/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => GetProviderTokenViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewmodel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        // ChangeNotifierProvider(create: (_) => NewsDetailsListModel()),
        // ChangeNotifierProvider(create: (_) => DoctorListModel()),
      ],
      child: Sizer(builder: (context, orientation, DeviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: AppPrimaryColor,
          ),
          // home: LoginScreen(),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
        );
      }),
    );
  }
}
