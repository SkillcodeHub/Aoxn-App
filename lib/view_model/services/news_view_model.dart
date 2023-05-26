import 'package:axonweb/data/response/api_response.dart';
import 'package:axonweb/Model/news_model.dart';
import 'package:axonweb/Repository/Get_Repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/Get_Model/customer_token.dart';

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
  List<CustomerTokenModel> _tokens = [];
  List<CustomerTokenModel> get tokens => _tokens;

  addToken(List<CustomerTokenModel> valToken) {
    valToken = _tokens;
  }

  final _myRepo = NewsRepository();
  ApiResponse<CustomerTokenModel> customertoken = ApiResponse.loading();
  setCustomerToken(ApiResponse<CustomerTokenModel> response) {
    customertoken = response;
    notifyListeners();
  }

  Future<void> fetchCustomerTokenApi(BuildContext context) async {
    setCustomerToken(ApiResponse.loading());

    _myRepo.fetchCustomerToken().then((value) async {
      final tokenProvider =
          Provider.of<CustomerTokenModel>(context, listen: false);
      final prefs = await SharedPreferences.getInstance();
      tokens.add(CustomerTokenModel(data: value.data!.token as dynamic));
      await prefs.setStringList('tokens', addToken(tokens.toList()));
      notifyListeners();
    }).onError((error, stackTrace) {
      setCustomerToken(ApiResponse.error(error.toString()));
    });
  }
}
