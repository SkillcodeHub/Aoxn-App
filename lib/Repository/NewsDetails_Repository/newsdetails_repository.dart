import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/NewsDetails_Model/newsdetails_model.dart';
import '../../Res/app_url.dart';

class NewsDetailsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<NewsDetailsListModel> fetchNewsDetailsList(
      String token, String newsId) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.newsDetailsUrl +
              '?CustomerToken=' +
              token.toString() +
              "&newsid=" +
              newsId.toString());
      print(response);
      return response = NewsDetailsListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
