import 'package:axonweb/Data/Response/api_response.dart';
import 'package:axonweb/Model/DoctorDetails_Model/doctordetails_model.dart';
import 'package:flutter/material.dart';

import '../../Repository/Settings_Repository/settings_repository.dart';
import '../Services/SharePreference/SharePreference.dart';
import 'package:collection/collection.dart';

UserPreferences userPreference = UserPreferences();

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

  Future<void> fetchDoctorDetailsListApi(String token) async {
    setDoctorDetailsList(ApiResponse.loading());
    _myRepo.fetchDoctorDetailsList(token).then((value) {
      setDoctorDetailsList(ApiResponse.completed(value));

      final doctorName =
          doctorDetailsList.data!.data![0].customerName.toString();
      print(doctorName);
      print(token);

      List<Map<String, dynamic>> getUniqueData(
          List<Map<String, dynamic>> data) {
        Set<String> uniqueKeys = Set<String>();
        List<Map<String, dynamic>> uniqueData = [];

        for (var item in data) {
          String key = '${item['doctorName']}-${item['token']}';
          if (!uniqueKeys.contains(key)) {
            uniqueKeys.add(key);
            uniqueData.add(item);
          }
        }

        return uniqueData;
      }

      void getData1() async {
        List<Map<String, dynamic>>? storedData =
            await userPreference.getDataFromSharedPreferences();
        print("storedDatastoredDatastoredData");
        print(storedData);
        print("storedDatastoredDatastoredData");
        Map<String, dynamic> newItem = {
          "doctorName": doctorName,
          "token": token,
        };
        storedData?.add(newItem);
        List<Map<String, dynamic>> uniqueData = getUniqueData(storedData!);
        userPreference.saveDataToSharedPreferences(uniqueData);
      }

      getData1();
    }).onError((error, stackTrace) {
      setDoctorDetailsList(ApiResponse.error(error.toString()));
    });
  }
}
