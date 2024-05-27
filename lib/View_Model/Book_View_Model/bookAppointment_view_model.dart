import 'dart:async';

import 'package:axonweb/Utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Repository/Book_Repository/bookAppointment_repository.dart';
import '../../Utils/utils.dart';
import '../Settings_View_Model/settings_view_model.dart';

class BookAppointmentViewModel with ChangeNotifier {
  final _myRepo = BookAppointmentRepository();

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> bookApointmentApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _myRepo.bookappointmentapi(data).then((value) {
      if (value['status'] == true) {
        setSignUpLoading(false);
        Utils.flushBarErrorMessage(
            "Appointment Book Successfully", Duration(seconds: 2), context);
        Timer(
            Duration(seconds: 2),
            () => Navigator.pushNamed(context, RoutesName.appointmentDetails,
                arguments: value));

        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        setSignUpLoading(false);
        final settingsViewModel =
            Provider.of<SettingsViewModel>(context, listen: false);

        if (settingsViewModel
                .doctorDetailsList.data!.data![0].isAdvanceBookingRequired
                .toString() ==
            'true') {
          Widget okButton = CupertinoDialogAction(
            child: Text(
              "OK",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFFFD5722),
              ),
            ),
            onPressed: () {
              Navigator.of(context)
                ..pop()
                ..pop();
            },
          );

// set up the CupertinoAlertDialog
          CupertinoAlertDialog alert = CupertinoAlertDialog(
            title: Text("Alert"),
            content: Text(value['displayMessage']),
            actions: [
              okButton,
            ],
          );

// show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        } else {
          Utils.flushBarErrorMessage(
              value['displayMessage'], Duration(seconds: 2), context);
          // Utils.snackBar(value['displayMessage'], context);
        }

        if (kDebugMode) {
          print(value.toString());
        }
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);

      if (kDebugMode) {
        Utils.flushBarErrorMessage(
            error.toString(), Duration(seconds: 3), context);
        print(error.toString());
      }
    });
  }
}
