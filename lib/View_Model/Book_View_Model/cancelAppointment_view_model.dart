import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../Repository/Book_Repository/cancelAppointment_repository.dart';
import '../../Utils/utils.dart';
import '../../utils/routes/routes_name.dart';

class CancelAppointmentViewModel with ChangeNotifier {
  final _myRepo = CancelAppointmentRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> cancelApointmentApi(dynamic data, BuildContext context) async {
    print('datadatadatadatadatadatadatadatadatadata');
    print(data);
    print('datadatadatadatadatadatadatadatadatadatadatadata');
    setSignUpLoading(true);
    _myRepo.cancelappointmentapi(data).then((value) {
      setSignUpLoading(false);
      // Utils.flushBarErrorMessage(
      //     'Otp is Valid'.toString(), Duration(seconds: 5), context);

      if (value['status'] == true) {
        // Utils.snackBar('Appointment Cancel Successfully', context);
        // showAlert(BuildContext context) {
        // set up the button
        Widget okButton = TextButton(
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
            // status = 'canceled';
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
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
        // }

        print(value);
        // Timer(
        //     Duration(seconds: 2),
        //     () => Navigator.pushNamed(context, RoutesName.appointmentDetails,
        //         arguments: value));

        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        // Utils.snackBar(value['displayMessage'], context);
        Widget okButton = TextButton(
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
            // status = 'canceled';
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
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
        if (kDebugMode) {
          print(value.toString());
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(
            error.toString(), Duration(seconds: 3), context);
        print(error.toString());
      }
    });
  }
}
