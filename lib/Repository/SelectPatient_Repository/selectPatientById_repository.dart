import 'package:flutter/foundation.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/SelectPatient_Model/selectPatientById_Model.dart';
import '../../Res/app_url.dart';

class SelectPatientByIdRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<SelectPatientByIdModel> fetchSelectPatientById(
      String token, String patientById) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getpatientbyid +
              "?caseno=" +
              patientById +
              "&customerToken=" +
              token);
      if (kDebugMode) {
        print(response);
      }
      return response = SelectPatientByIdModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
