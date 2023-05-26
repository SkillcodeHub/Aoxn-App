import 'package:axonweb/data/network/BaseApiServices.dart';
import 'package:axonweb/data/network/NetworkApiService.dart';

import '../../res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginapi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> otpverifyapi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.otpverifyUrl, data);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  // ?CustomerToken=68cb311f-585a-4e86-8e89-06edf1814080

  // ApiResponse<GetProviderTokenModel> data = ApiResponse.loading();
  // setMoviesList(ApiResponse<GetProviderTokenModel> response) {
  //   data = response;
  // }
}
