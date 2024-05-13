import '../../Model/CustomerToken_Model/customer_token.dart';
import '../../Model/News_Model/news_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';
import '../../res/app_url.dart';

class NewsRepository {
  CustomerTokenModel customerTokenViewmodel = CustomerTokenModel();
  BaseApiServices _apiServices = NetworkApiService();

  Future<NewsListModel> fetchNewsList(String token, String letId) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.newsUrl +
          '?CustomerToken=' +
          token.toString() +
          '&lat=' +
          letId.toString());
      return response = NewsListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
