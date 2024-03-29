import 'package:flutter/foundation.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/AppointmentSlot_Model/appointmentSlot_model.dart';
import '../../Res/app_url.dart';

class AppointmentSlotListRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<AppointmentSlotListModel> fetchAppointmentSlotList(
      selectedDocotrId, datetime1, token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getAppointmentstimeslot +
              "?DoctorId=" +
              selectedDocotrId +
              "&ApptDate=" +
              datetime1.toString() +
              "&customerToken=" +
              token.toString());
      if (kDebugMode) {
        print(response);
      }
      return response = AppointmentSlotListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
