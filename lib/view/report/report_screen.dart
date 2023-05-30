import 'package:flutter/material.dart';

import '../../Res/colors.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/payment_widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Color(0xffffffff),
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AxonIconForAppBarrWidget(),
                ScreenNameWidget(
                  title: '  Recent Precription',
                ),
                WhatsappWidget(),
                PaymentWidget(),
                SettingsWidget(),
              ],
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     userPrefernce.remove().then((value) {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => LoginScreen()));
          //     });
          //   },
          //   child: Text('Logout'),
          // )
        ),
      ),
    );
  }
}
