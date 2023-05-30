import 'package:axonweb/Data/Response/api_response.dart';
import 'package:axonweb/Model/DoctorDetails_Model/doctordetails_model.dart';
import 'package:flutter/material.dart';

import '../../Repository/Settings_Repository/settings_repository.dart';

class SettingsViewModel with ChangeNotifier {
  final _myRepo = SettingsRepository();
  ApiResponse<DoctorDetailsListModel> doctorDetailsList = ApiResponse.loading();
  setDoctorDetailsList(ApiResponse<DoctorDetailsListModel> response) {
    doctorDetailsList = response;
    print('doctorDetailsList');
    print(doctorDetailsList);
    print("doctorDetailsList");
    notifyListeners();
  }

  Future<void> fetchDoctorDetailsListApi() async {
    setDoctorDetailsList(ApiResponse.loading());
    _myRepo.fetchDoctorDetailsList().then((value) {
      setDoctorDetailsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDoctorDetailsList(ApiResponse.error(error.toString()));
    });
  }
}
