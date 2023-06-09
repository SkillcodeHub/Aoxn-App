import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class CancelAppointmentRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> cancelappointmentapi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.cancelAppointmentUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
