import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Model/AppointmentSlot_Model/appointmentSlot_model.dart';
import '../../Repository/AppointmentSlot_Repository/appointmentSlot_repository.dart';

class AppointmentSlotListViewmodel with ChangeNotifier {
  final _myRepo = AppointmentSlotListRepository();
  ApiResponse<AppointmentSlotListModel> AppointmentSlotList =
      ApiResponse.loading();
  setAppointmentSlotList(ApiResponse<AppointmentSlotListModel> response) {
    AppointmentSlotList = response;
    print(AppointmentSlotList);
    notifyListeners();
  }

  Future<void> fetchAppointmentSlotListApi(
      String selectedDocotrId, String datetime1, String token) async {
    setAppointmentSlotList(ApiResponse.loading());
    _myRepo
        .fetchAppointmentSlotList(selectedDocotrId, datetime1, token)
        .then((value) {
      setAppointmentSlotList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setAppointmentSlotList(ApiResponse.error(error.toString()));
    });
  }
}
