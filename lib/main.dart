import 'package:axonweb/res/colors.dart';
import 'package:axonweb/utils/routes/routes.dart';
import 'package:axonweb/view_model/auth_view_model.dart';
import 'package:axonweb/view_model/provider_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
