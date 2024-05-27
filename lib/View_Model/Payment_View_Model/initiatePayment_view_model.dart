import 'package:axonweb/View_Model/Payment_View_Model/validatePayment_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../Repository/Payment_Repository/initiatePayment_repository.dart';
import '../../Utils/utils.dart';

class InitiatePaymentViewModel with ChangeNotifier {
  late Razorpay _razorpay;

  final _myRepo = InitiatePaymentRepository();
  dynamic userData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setisLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> initiatePaymentApi(dynamic data, BuildContext context) async {
    ValidatePaymentViewModel validatePaymentViewModel =
        ValidatePaymentViewModel();
    userData = data;
    void _handlePaymentSuccess(PaymentSuccessResponse response) {
      print("++++++============");
      print("paymentId: ${response.paymentId}");
      print("orderId: ${response.orderId}");
      print("signature: ${response.signature}");

      Map paymentData = {
        'customerId': '99999999',
        'razorpayOrderId': response.orderId.toString(),
        'razorpayPaymentId': response.paymentId.toString(),
        'razorpaySignature': response.signature.toString(),
        'customerToken': userData['customerToken'],
        'lat': userData['lat'],
      };

      print(response.orderId.toString());
      print(
        response.paymentId.toString(),
      );
      print(response.signature.toString());
      print(userData['customerToken']);
      print(userData['lat']);

      validatePaymentViewModel.validatePaymentApi(paymentData, context);

      Fluttertoast.showToast(
          msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
    }

    void _handlePaymentError(PaymentFailureResponse response) {
      Fluttertoast.showToast(
          msg: "ERROR HERE: ${response.code} - ${response.message}",
          timeInSecForIosWeb: 4);
    }

    void _handleExternalWallet(ExternalWalletResponse response) {
      Fluttertoast.showToast(
          msg: "EXTERNAL_WALLET IS: ${response.walletName}",
          timeInSecForIosWeb: 4);
    }

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    setisLoading(true);
    _myRepo.initiatePaymentApi(data).then((value) {
      setisLoading(false);

      if (value['status'] == true) {
        print(value);

        var options = {
          'key': 'rzp_test_8aGQyjie2ef5rn',
          'order_id': value['data']['razorpayOrderId'],

          'amount': (int.parse(data['amount']) * 100).toString(), // Rs 200
          'name': data['name'],
          'description': 'User Payment Request',
          'prefill': {
            'contact': data['mobile'],
            'email': data['email'],
          }
        };

        try {
          _razorpay.open(options);
        } catch (e) {
          debugPrint(e.toString());
        }
        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        Utils.flushBarErrorMessage(
            value['displayMessage'], Duration(seconds: 2), context);

        // Utils.snackBar(value['displayMessage'], context);
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
