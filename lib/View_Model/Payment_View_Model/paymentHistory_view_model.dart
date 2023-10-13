import 'dart:async';
import 'package:axonweb/Model/Payment_Model/paymentHistory_model.dart';
import 'package:axonweb/Repository/Payment_Repository/paymentHistory_repository.dart';
import 'package:axonweb/data/response/api_response.dart';
import 'package:flutter/material.dart';

class PaymentHistoryViewmodel with ChangeNotifier {
  final _myRepo = PaymentHistoryRepository();
  ApiResponse<PaymentHistoryModel> paymentHistoryList = ApiResponse.loading();
  setPaymentHistory(ApiResponse<PaymentHistoryModel> response) {
    paymentHistoryList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loading1 = false;
  bool get loading1 => _loading1;

  setLoading1(bool value) {
    _loading1 = value;
    notifyListeners();
  }

  Future<void> fetchPaymentHistoryApi(
      String token, String latId, String mobile) async {
    setPaymentHistory(ApiResponse.loading());
    _myRepo.fetchPaymentHistory(token, latId, mobile).then((value) {
      setPaymentHistory(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setPaymentHistory(ApiResponse.error(error.toString()));
    });
  }
}
