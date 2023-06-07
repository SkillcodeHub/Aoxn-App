import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Model/SelectPatient_Model/getPatientByMobile_model.dart';
import '../../Repository/SelectPatient_Repository/getPatientByMobile_repository.dart';

class GetPatientByMobileListViewmodel with ChangeNotifier {
  final _myRepo = GetPatientByMobileRepository();
  ApiResponse<GetPatientByMobileModel> GetPatientByMobileList =
      ApiResponse.loading();
  setGetPatientByMobileList(ApiResponse<GetPatientByMobileModel> response) {
    GetPatientByMobileList = response;
    print(GetPatientByMobileList);
    notifyListeners();
  }

  Future<void> fetchGetPatientByMobileListApi(
      String token, String mobile) async {
    setGetPatientByMobileList(ApiResponse.loading());
    _myRepo.fetchGetPatientByMobileList(token, mobile).then((value) {
      setGetPatientByMobileList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setGetPatientByMobileList(ApiResponse.error(error.toString()));
    });
  }
}
