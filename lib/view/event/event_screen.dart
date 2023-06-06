import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Res/colors.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/payment_widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    Future refresh() async {}
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
                  title: '  Events',
                ),
                WhatsappWidget(),
                // PaymentWidget(),
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
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  height: 74.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Swipe down to refresh page',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0XFF545454),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 120,
                      ),
                      Center(
                        child: Image.asset(
                          'images/axon.png',
                          height: 90,
                          width: 90,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'You  don\'t have any bookings or upcoming events',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0XFF545454),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
