import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Model/SelectPatient_Model/selectPatientById_Model.dart';
import '../../Repository/SelectPatient_Repository/selectPatientById_repository.dart';

class SelectPatientByIdViewmodel with ChangeNotifier {
  final _myRepo = SelectPatientByIdRepository();
  ApiResponse<SelectPatientByIdModel> SelectPatientById = ApiResponse.loading();
  setSelectPatientById(ApiResponse<SelectPatientByIdModel> response) {
    SelectPatientById = response;
    print(SelectPatientById);
    notifyListeners();
  }

  Future<void> fetchSelectPatientByIdApi(
      String token, String patientById) async {
    setSelectPatientById(ApiResponse.loading());
    _myRepo.fetchSelectPatientById(token, patientById).then((value) {
      setSelectPatientById(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setSelectPatientById(ApiResponse.error(error.toString()));
    });
  }
}
