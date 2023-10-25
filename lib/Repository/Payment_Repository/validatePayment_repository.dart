import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class ValidatePaymentRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> validatePaymentUserapi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.validatePaymentUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
