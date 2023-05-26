import 'dart:convert';

import '../../Model/Get_Model/customer_token.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';
import '../../Model/news_model.dart';
import '../../res/app_url.dart';

class NewsRepository {
  CustomerTokenModel customerTokenViewmodel = CustomerTokenModel();
  BaseApiServices _apiServices = NetworkApiService();
  static String? cusToken;
  Future<CustomerTokenModel> fetchCustomerToken() async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse(AppUrl.customertoken + '?Appcode=demo');
      final data = jsonDecode(response.body.toString());
      cusToken = data['data']['token'];
      print(cusToken);
      return response = CustomerTokenModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<NewsListModel> fetchNewsList(String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.newsUrl + '?CustomerToken=' + token.toString());
      return response = NewsListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
//  '?CustomerToken=68cb311f-585a-4e86-8e89-06edf1814080'