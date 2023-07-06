import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../res/app_url.dart';

class InitiatePaymentRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> initiatePaymentApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.initiatepaymenturl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
