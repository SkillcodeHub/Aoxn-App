import 'dart:async';
import 'package:axonweb/data/response/api_response.dart';
import 'package:flutter/material.dart';
import '../../Model/Payment_Model/customerPayHead_model.dart';
import '../../Repository/Payment_Repository/customer_payhead_repository.dart';

class CustomerPayHeadViewmodel with ChangeNotifier {
  final _myRepo = CustomerPayHeadRepository();
  ApiResponse<CustomerPayHeadListModel> CustomerPayHeadList =
      ApiResponse.loading();
  setCustomerPayHeadList(ApiResponse<CustomerPayHeadListModel> response) {
    CustomerPayHeadList = response;
    notifyListeners();
  }

  Future<void> fetchCustomerPayHeadListApi(String token) async {
    setCustomerPayHeadList(ApiResponse.loading());
    _myRepo.fetchCustomerPayHeadList(token).then((value) {
      setCustomerPayHeadList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCustomerPayHeadList(ApiResponse.error(error.toString()));
    });
  }
}
