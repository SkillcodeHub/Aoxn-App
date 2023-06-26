import 'dart:async';
import 'dart:io';
import 'package:axonweb/View_Model/Settings_View_Model/settings_view_model.dart';
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
  SettingsViewModel settingsViewModel = SettingsViewModel();
  late String token;

  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
      });
    });

    super.initState();
    // final bookAppointmentViewModel =
    //     Provider.of<BookAppointmentViewModel>(context, listen: false);
    Timer(Duration(microseconds: 20), () {
      settingsViewModel.fetchDoctorDetailsListApi(token);
    });
  }

  whatsapp() async {
    print('object');
    print(settingsViewModel.doctorDetailsList.data!.data![0].whatsapplink
        .toString());
    print('object');

    var whatsAppUrl = settingsViewModel
        .doctorDetailsList.data!.data![0].whatsapplink
        .toString();
    final uri = Uri.parse(whatsAppUrl);
    final phoneNumber = uri.pathSegments.last;

    var contact = "'+$phoneNumber'";

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

//   whatsapp() async {
//   String? whatsappUrl = settingsViewModel
//       .doctorDetailsList.data!.data![0].whatsapplink
//       .toString();

//   if (whatsappUrl != null && whatsappUrl.isNotEmpty) {
//     final uri = Uri.parse(whatsappUrl);
//     final phoneNumber = uri.pathSegments.last;

//     final cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D+'), '');
//     final encodedMessage = Uri.encodeComponent('');

//     try {
//       if (Platform.isIOS) {
//         // Construct the WhatsApp URL for iOS
//         final iosUrl = "whatsapp://send?phone=$cleanedPhoneNumber&text=$encodedMessage";
//         await launchUrl(iosUrl as Uri);
//       } else {
//         // Construct the WhatsApp URL for Android
//         final androidUrl = "https://wa.me/$cleanedPhoneNumber?text=$encodedMessage";
//         await launch(androidUrl);
//       }
//     } catch (e) {
//       Utils.snackBar('WhatsApp is not installed.', context);
//     }
//   } else {
//     Utils.snackBar('WhatsApp link is not available.', context);
//   }
// }


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
