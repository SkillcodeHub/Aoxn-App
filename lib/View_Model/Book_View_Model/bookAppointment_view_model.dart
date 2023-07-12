import 'dart:async';

import 'package:axonweb/Utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../Repository/Book_Repository/bookAppointment_repository.dart';
import '../../Utils/utils.dart';

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
    print('datadatadatadatadatadatadatadatadatadata');
    print(data);
    print('datadatadatadatadatadatadatadatadatadatadatadata');
    _myRepo.bookappointmentapi(data).then((value) {
      // Utils.flushBarErrorMessage(
      //     'Otp is Valid'.toString(), Duration(seconds: 5), context);

      if (value['status'] == true) {
      setSignUpLoading(false);
        Utils.snackBar('Appointment Book Successfully', context);
        print(value);
        Timer(
            Duration(seconds: 2),
            () => Navigator.pushNamed(context, RoutesName.appointmentDetails,
                arguments: value));

        if (kDebugMode) {
          print(value.toString());
        }
      } else {
              setSignUpLoading(false);

        Utils.snackBar(value['displayMessage'], context);
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
