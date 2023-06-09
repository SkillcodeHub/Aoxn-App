import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Model/EventList_Model/eventList_model.dart';
import '../../Repository/EventList_Repository/eventList_repository.dart';

class EventListViewmodel with ChangeNotifier {
  final _myRepo = EventListRepository();
  ApiResponse<EventListModel> EventList = ApiResponse.loading();
  setEventList(ApiResponse<EventListModel> response) {
    EventList = response;
    print(EventList);
    notifyListeners();
  }

  Future<void> fetchEventListApi(String deviceId, String token) async {
    setEventList(ApiResponse.loading());
    _myRepo.fetchEventList(deviceId, token).then((value) {
      setEventList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setEventList(ApiResponse.error(error.toString()));
    });
  }
}
