import '../../Model/ValidateAppUser_Model/validateappuser_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';
import '../../res/app_url.dart';

class ValidateAppUserRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ValidateAppUserModel> validateAppUser(
    String platform,
    String deviceId,
    String loginAuthToken,
  ) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.validateappuserurl +
              '?platform=' +
              platform.toString() +
              '&device=' +
              deviceId.toString() +
              '&loginAuthToken=' +
              loginAuthToken.toString());
      return response = ValidateAppUserModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
