import 'dart:async';
import 'dart:io';
import 'package:axonweb/View_Model/Settings_View_Model/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/utils.dart';

class WhatsappWidget extends StatefulWidget {
  const WhatsappWidget({
    super.key,
  });

  @override
  State<WhatsappWidget> createState() => _WhatsappWidgetState();
}

class _WhatsappWidgetState extends State<WhatsappWidget> {
  SettingsViewModel settingsViewModel = SettingsViewModel();
  late String token;

  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
      });
    });

    super.initState();
    Timer(Duration(microseconds: 20), () {
      settingsViewModel.fetchDoctorDetailsListApi(token);
    });
  }

  whatsapp() async {
    var whatsAppUrl = settingsViewModel
        .doctorDetailsList.data!.data![0].whatsapplink
        .toString();
    final uri = Uri.parse(whatsAppUrl);
    final phoneNumber = uri.pathSegments.last;

    var contact = "'+$phoneNumber'";
    var androidUrl = "whatsapp://send?phone=$contact&text=";
    var iosUrl = "https://wa.me/$phoneNumber?text=${Uri.parse('')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      Utils.snackBar('WhatsApp is not installed.', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        whatsapp();
      },
      child: Container(
        margin: EdgeInsets.all(6),
        height: 3.h,
        child: Image.asset('images/whatsapp.png'),
      ),
    );
  }
}
