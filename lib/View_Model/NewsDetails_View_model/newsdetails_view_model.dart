import 'dart:async';

import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Model/NewsDetails_Model/newsdetails_model.dart';
import '../../Repository/NewsDetails_Repository/newsdetails_repository.dart';

class NewsDetailsViewmodel with ChangeNotifier {
  final _myRepo = NewsDetailsRepository();
  ApiResponse<NewsDetailsListModel> newsDetailsList = ApiResponse.loading();
  setNewsDetailsList(ApiResponse<NewsDetailsListModel> response) {
    newsDetailsList = response;
    print(newsDetailsList);
    notifyListeners();
  }

  Future<void> fetchNewsDetailsListApi(
      context, String token, String newsId) async {
    setNewsDetailsList(ApiResponse.loading());
    _myRepo.fetchNewsDetailsList(token, newsId).then((value) {
      setNewsDetailsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setNewsDetailsList(ApiResponse.error(error.toString()));
    });
  }
}
