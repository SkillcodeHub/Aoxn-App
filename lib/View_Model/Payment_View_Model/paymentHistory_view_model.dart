// import 'dart:async';
// import 'package:axonweb/data/response/api_response.dart';
// import 'package:flutter/material.dart';

// class PaymentHistoryViewmodel with ChangeNotifier {
//   final _myRepo = PaymentHistoryRepository();
//   ApiResponse<PaymentHistoryModel> paymentHistoryList = ApiResponse.loading();
//   setPaymentHistory(ApiResponse<PaymentHistoryModel> response) {
//     paymentHistoryList = response;
//     notifyListeners();
//   }

//   bool _loading = false;
//   bool get loading => _loading;

//   setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

//   Future<void> fetchPaymentHistoryApi(String token) async {
//     setPaymentHistory(ApiResponse.loading());
//     _myRepo.fetchPaymentHistory(token).then((value) {
//       setPaymentHistory(ApiResponse.completed(value));
//     }).onError((error, stackTrace) {
//       setPaymentHistory(ApiResponse.error(error.toString()));
//     });
//   }
// }
