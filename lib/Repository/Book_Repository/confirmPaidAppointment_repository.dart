import '../../Res/app_url.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';

class ConfirmPaidAppointmentRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> confirmPaidAppointmentApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.confirmPaidAppointmentUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
