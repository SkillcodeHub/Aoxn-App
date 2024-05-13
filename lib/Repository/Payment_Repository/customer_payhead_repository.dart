import '../../Model/Payment_Model/customerPayHead_model.dart';
import '../../Res/app_url.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';

class CustomerPayHeadRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<CustomerPayHeadListModel> fetchCustomerPayHeadList(
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getcustomerpayhead + '?CustomerToken=' + token.toString());
      return response = CustomerPayHeadListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
