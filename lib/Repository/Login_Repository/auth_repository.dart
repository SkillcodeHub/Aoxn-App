import 'package:axonweb/data/network/BaseApiServices.dart';
import 'package:axonweb/data/network/NetworkApiService.dart';
import 'package:flutter/foundation.dart';

import '../../res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginapi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> otpverifyapi(dynamic otpVerifyData) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.otpverifyUrl, otpVerifyData);
      if (kDebugMode) {
        print(response);
      }
      return response;
    } catch (e) {
      throw e;
    }
  }
}
