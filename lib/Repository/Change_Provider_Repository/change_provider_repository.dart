import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/CustomerToken_Model/customer_token.dart';
import '../../Res/app_url.dart';

class ChangeProviderRepository {
  BaseApiServices _apiServices = NetworkApiService();
  CustomerTokenModel customerTokenViewmodel = CustomerTokenModel();

  Future<CustomerTokenModel> fetchCustomerToken(String appCode) async {
    try {
      print('appCode');
      print(appCode);
      print('appCode');
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.customertoken + '?Appcode=' + appCode.toString());
      print(response);
      return response = CustomerTokenModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<CustomerTokenModel> fetchCustomerTokenByQR(String appCode) async {
    try {
      print('appCode');
      print(appCode);
      print('appCode');
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.customertoken + 'V2?Appcode=' + appCode.toString());
      print(response);
      return response = CustomerTokenModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
