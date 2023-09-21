import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class AdvanceBookAppointmentRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> advancebookappointmentapi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.advancebookAppointmentUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
