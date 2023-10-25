import 'package:flutter/foundation.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/DoctorDetails_Model/doctordetails_model.dart';
import '../../Res/app_url.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';

class SettingsRepository {
  BaseApiServices _apiServices = NetworkApiService();
  UserPreferences userPreference = UserPreferences();
  Future<DoctorDetailsListModel> fetchDoctorDetailsList(token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getdoctordetailsUrl + '?CustomerToken=' + token.toString());
      if (kDebugMode) {
        print(response);
      }
      return response = DoctorDetailsListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
