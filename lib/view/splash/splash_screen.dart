import 'package:axonweb/view_model/services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splasheSrvices = SplashServices();
  @override
  void initState() {
    super.initState();
    splasheSrvices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        "Axon",
        style: Theme.of(context).textTheme.headline4,
      ),
    ));
  }
}
