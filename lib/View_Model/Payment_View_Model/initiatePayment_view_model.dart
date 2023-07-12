import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Repository/Payment_Repository/initiatePayment_repository.dart';
import '../../Utils/utils.dart';

class InitiatePaymentViewModel with ChangeNotifier {
  final _myRepo = InitiatePaymentRepository();

  // bool _loading = false;
  // bool get loading => _loading;
  // setLoading(bool value) {
  //   _loading = value;
  //   notifyListeners();
  // }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setisLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> initiatePaymentApi(dynamic data, BuildContext context) async {
    print('datadatadatadatadatadatadatadatadatadata');
    print(data);
    print('datadatadatadatadatadatadatadatadatadatadatadata');
    setisLoading(true);
    _myRepo.initiatePaymentApi(data).then((value) {
      setisLoading(false);
      // Utils.flushBarErrorMessage(
      //     'Otp is Valid'.toString(), Duration(seconds: 5), context);

      if (value['status'] == true) {
        // Utils.snackBar('Appointment Book Successfully', context);
        print(value);
        // Timer(
        //     Duration(seconds: 2),
        //     () => Navigator.pushNamed(context, RoutesName.appointmentDetails,
        //         arguments: value));

        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        Utils.snackBar(value['displayMessage'], context);
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
