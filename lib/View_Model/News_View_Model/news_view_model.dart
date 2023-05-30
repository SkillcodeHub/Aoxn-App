import 'dart:async';

import 'package:axonweb/data/response/api_response.dart';

import 'package:flutter/material.dart';

import '../../Model/CustomerToken_Model/customer_token.dart';
import '../../Model/News_Model/news_model.dart';
import '../../Repository/News_Repository/repository.dart';
import '../../utils/routes/routes_name.dart';
import '../Services/SharePreference/SharePreference.dart';

class NewsViewmodel with ChangeNotifier {
  final _myRepo = NewsRepository();
  ApiResponse<NewsListModel> newsList = ApiResponse.loading();
  setNewsList(ApiResponse<NewsListModel> response) {
    newsList = response;
    notifyListeners();
  }

  Future<void> fetchNewsListApi(String token) async {
    setNewsList(ApiResponse.loading());
    _myRepo.fetchNewsList(token).then((value) {
      setNewsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setNewsList(ApiResponse.error(error.toString()));
    });
  }
}

class CustomerTkenViewmodel with ChangeNotifier {
  UserPreferences userPreference = UserPreferences();

  final _myRepo = ChangeProviderRepository();
  ApiResponse<CustomerTokenModel> customertoken = ApiResponse.loading();
  setCustomerToken(ApiResponse<CustomerTokenModel> response) {
    customertoken = response;
    print(customertoken);
    notifyListeners();
  }

  Future<void> fetchCustomerTokenApi(context, String appCode) async {
    setCustomerToken(ApiResponse.loading());
    _myRepo.fetchCustomerToken(appCode).then((value) {
      setCustomerToken(ApiResponse.completed(value));

      final token = customertoken.data!.data!.token.toString();
      print(token);
      userPreference.setToken(token);
      // final userPreference =
      //     Provider.of<GetTokenViewModel>(context, listen: false);
      // userPreference.saveProviderToken(CustomerTokenModel(
      //     ));
      Timer(
          Duration(seconds: 1),
          () => Navigator.pushNamed(
                context,
                RoutesName.news,
              ));
    }).onError((error, stackTrace) {
      setCustomerToken(ApiResponse.error(error.toString()));
    });
  }
}
