import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class RegisterAppUserRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> registerAppUserApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.registerappuserurl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
