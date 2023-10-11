import 'package:axonweb/Model/Payment_Model/paymentHistory_model.dart';
import 'package:axonweb/Res/app_url.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';

class PaymentHistoryRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<PaymentHistoryModel> fetchPaymentHistory(
      String token, String latId, String mobile) async {
    print(token);

    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.paymentHistoryUrl +
              '?CustomerToken=' +
              token.toString() +
              '&lat=' +
              latId +
              '&mobile=' +
              mobile);
      return response = PaymentHistoryModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
