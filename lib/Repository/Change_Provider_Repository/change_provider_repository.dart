import 'package:flutter/foundation.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/CustomerToken_Model/customer_token.dart';
import '../../Res/app_url.dart';

class ChangeProviderRepository {
  BaseApiServices _apiServices = NetworkApiService();
  CustomerTokenModel customerTokenViewmodel = CustomerTokenModel();

  Future<CustomerTokenModel> fetchCustomerToken(String appCode) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.customertoken + '?Appcode=' + appCode.toString());
      if (kDebugMode) {
        print(response);
      }
      return response = CustomerTokenModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<CustomerTokenModel> fetchCustomerTokenByQR(String appCode) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.customertoken + 'V2?Appcode=' + appCode.toString());
      if (kDebugMode) {
        print(response);
      }
      return response = CustomerTokenModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
