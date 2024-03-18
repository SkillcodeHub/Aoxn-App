import 'package:axonweb/Repository/Book_Repository/advanceBookAppointment_repository.dart';
import 'package:axonweb/View_Model/Book_View_Model/confirmPaidAppointment_View_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../Utils/utils.dart';

class AdvanceBookAppointmentViewModel with ChangeNotifier {
  late Razorpay _razorpay;

  final _myRepo = AdvanceBookAppointmentRepository();
  dynamic userData;

  bool _UpLoading = false;
  bool get UpLoading => _UpLoading;

  setLoading(bool value) {
    _UpLoading = value;
    notifyListeners();
  }

  bool _Ploading = false;
  bool get Ploading => _Ploading;
  setPLoading(bool value) {
    _Ploading = value;
    notifyListeners();
  }

  Future<void> advancebookappointmentapi(
      dynamic data, BuildContext context) async {
    ConfirmPaidAppointmentViewModel confirmPaidAppointmentViewModel =
        ConfirmPaidAppointmentViewModel();
    userData = data;

    void _handlePaymentSuccess(PaymentSuccessResponse response) {
      print("++++++============");
      print("paymentId: ${response.paymentId}");
      print("orderId: ${response.orderId}");
      print("signature: ${response.signature}");

      Map paymentData = {
        //   'customerId': '99999999',
        'RazorpayOrderId': response.orderId.toString(),
        'RazorpayPaymentId': response.paymentId.toString(),
        'RazorpaySignature': response.signature.toString(),
        'CustomerToken': userData['CustomerToken'],
        'LAT': userData['LAT'],
      };

      print(response.orderId.toString());
      print(
        response.paymentId.toString(),
      );
      print(response.signature.toString());
      print(userData['CustomerToken']);
      print(userData['LAT']);

      // validatePaymentViewModel.validatePaymentApi(paymentData, context);
      confirmPaidAppointmentViewModel.confirmPaidAppointmentApi(
          paymentData, context);
      setPLoading(false);
      Fluttertoast.showToast(
          msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
    }

    void _handlePaymentError(PaymentFailureResponse response) {
      setPLoading(false);
      Fluttertoast.showToast(
          msg: "ERROR HERE: ${response.code} - ${response.message}",
          timeInSecForIosWeb: 4);
    }

    void _handleExternalWallet(ExternalWalletResponse response) {
      setPLoading(false);
      Fluttertoast.showToast(
          msg: "EXTERNAL_WALLET IS: ${response.walletName}",
          timeInSecForIosWeb: 4);
    }

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    setLoading(true);
    print('datadatadatadatadatadatadatadatadatadata');
    print(data);

    print('datadatadatadatadatadatadatadatadatadatadatadata');
    Map data1 = {
      "CaseNo": data['CaseNo'],
      "Name": data['Name'],
      "Mobile": data['Mobile'],
      "Email": data['Email'],
      "Gender": data['Gender'],
      "PatType": data['PatType'],
      "ApptDate": data['ApptDate'],
      "CustomerToken": data['CustomerToken'],
      "DelayMinute": data['DelayMinute'],
      "DeviceId": data['DeviceId'],
      "DoctorId": data['DoctorId'],
      "TimingId": data['TimingId'],
      "AppointmentPaymentHead": data['AppointmentPaymentHead'],
      "Amount": data['Amount'],
    };
    _myRepo.advancebookappointmentapi(data1).then((value) {
      print('valuevaluevaluevaluevaluevaluevaluevalue');
      print(value);
      print(value['data']['razorPayOrder']['razorpayOrderId'].toString());
      print(data['Name']);
      print('valuevaluevaluevaluevaluevaluevaluevalue');
      if (value['status'] == true) {
        setPLoading(false);

        setLoading(false);
        print(value.toString());
        print(
            'keykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykey');
        print(value['data']['razorPayOrder']['razorpayKey'].toString());
        print(value['data']['razorPayOrder']['razorpayOrderId'].toString());
        print(
            'keykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykeykey');
        var options = {
          // 'key': 'rzp_test_8aGQyjie2ef5rn',
          'key': value['data']['razorPayOrder']['razorpayKey'].toString(),
          'order_id':
              value['data']['razorPayOrder']['razorpayOrderId'].toString(),

          'amount': (int.parse(data['Amount']) * 100).toString(), // Rs 200
          'name': data['Name'],
          'description': 'User Payment Request',
          'prefill': {
            'contact': data['Mobile'],
            'email': data['Email'],
          }
        };

        try {
          setPLoading(false);
          _razorpay.open(options);
        } catch (e) {
          debugPrint(e.toString());
        }
        if (kDebugMode) {
          print(value.toString());
        }
      } else if (value['status'] == false) {
        setPLoading(false);

        Utils.snackBar(value['displayMessage'], context);
        print(
            'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
        print(value['displayMessage']);
        print(
            'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
        if (kDebugMode) {
          print(value.toString());
        }
      }
    }).onError((error, stackTrace) {
      Utils.snackBar1(
          "Cannot book appointment. Online slot is full! please contact provider directly to take appointment.",
          Duration(seconds: 5),
          context);

      if (kDebugMode) {
        Utils.flushBarErrorMessage(
            error.toString(), Duration(seconds: 7), context);
        print(error.toString());
      }
    });
  }
}
