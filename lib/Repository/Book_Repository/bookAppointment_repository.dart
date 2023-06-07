import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class BookAppointmentRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> bookappointmentapi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.bookAppointmentUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
