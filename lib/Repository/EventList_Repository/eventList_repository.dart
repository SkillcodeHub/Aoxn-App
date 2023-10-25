import 'package:flutter/foundation.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/EventList_Model/eventList_model.dart';
import '../../Res/app_url.dart';

class EventListRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<EventListModel> fetchEventList(deviceId, token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getEventList +
              "?DeviceId=" +
              deviceId +
              "&CustomerToken=" +
              token.toString());
      if (kDebugMode) {
        print(response);
      }
      return response = EventListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
