import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Repository/Payment_Repository/validatePayment_repository.dart';
import '../../utils/utils.dart';
import '../Services/SharePreference/SharePreference.dart';

class ValidatePaymentViewModel with ChangeNotifier {
  final _myRepo = ValidatePaymentRepository();
  UserPreferences userPreference = UserPreferences();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> validatePaymentApi(dynamic data, BuildContext context) async {
    print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
    print(data);
    setLoading(true);
    await _myRepo.validatePaymentUserapi(data).then((value) {
      setLoading(false);

      if (value['status'] == true) {
        Utils.snackBar('OTP Send Successfully', context);
        userPreference.getUserData().then((value) {
          data = value!;
          print('data1');
          print(data);
          print('data1');
        });
        // Timer(
        //     Duration(seconds: 2),
        //     () =>
        //         Navigator.pushNamed(context, RoutesName.otp, arguments: data));

        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        print(value['displayMessage']);
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(
          error.toString(), Duration(seconds: 3), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
