import 'dart:async';

import 'package:axonweb/data/response/api_response.dart';
import 'package:flutter/material.dart';

import '../../Model/News_Model/news_model.dart';
import '../../Repository/News_Repository/repository.dart';

class NewsViewmodel with ChangeNotifier {
  final _myRepo = NewsRepository();
  ApiResponse<NewsListModel> newsList = ApiResponse.loading();
  setNewsList(ApiResponse<NewsListModel> response) {
    newsList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchNewsListApi(String token, String letId) async {
    setNewsList(ApiResponse.loading());
    _myRepo.fetchNewsList(token, letId).then((value) {
      print("value.status");
      print("value.status");

      setNewsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setNewsList(ApiResponse.error(error.toString()));
    });
  }
}
