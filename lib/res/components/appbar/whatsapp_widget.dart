import 'dart:io';
import 'package:flutter/material.dart';
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
  whatsapp() async {
    var contact = "+916353335967";
    var androidUrl = "whatsapp://send?phone=$contact&text=";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      Utils.snackBar('WhatsApp is not installed.', context);

      // EasyLoading.showError('WhatsApp is not installed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        whatsapp();
      },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 27,
        child: Image.asset('images/whatsapp.png'),
      ),
    );
  }
}
