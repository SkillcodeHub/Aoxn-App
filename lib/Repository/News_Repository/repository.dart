import '../../Model/CustomerToken_Model/customer_token.dart';
import '../../Model/News_Model/news_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiService.dart';
import '../../res/app_url.dart';

class NewsRepository {
  CustomerTokenModel customerTokenViewmodel = CustomerTokenModel();
  BaseApiServices _apiServices = NetworkApiService();

  Future<NewsListModel> fetchNewsList(String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.newsUrl + '?CustomerToken=' + token.toString());
      return response = NewsListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}

// class ChangeProviderRepository {
//   BaseApiServices _apiServices = NetworkApiService();
//   CustomerTokenModel customerTokenViewmodel = CustomerTokenModel();

//   Future<CustomerTokenModel> fetchCustomerToken(String appCode) async {
//     try {
//       print('appCode');
//       print(appCode);
//       print('appCode');
//       dynamic response = await _apiServices.getGetApiResponse(
//           AppUrl.customertoken + '?Appcode=' + appCode.toString());
//       print(response);
//       return response = CustomerTokenModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }
// }
//  '?CustomerToken=68cb311f-585a-4e86-8e89-06edf1814080'