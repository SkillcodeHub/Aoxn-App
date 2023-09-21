// import '../../data/network/BaseApiServices.dart';
// import '../../data/network/NetworkApiService.dart';
// import '../../res/app_url.dart';

// class PaymentHistoryRepository {
//   BaseApiServices _apiServices = NetworkApiService();

//   Future<PaymentHistoryModel> fetchPaymentHistory(String token) async {
//     print(token);

//     try {
//       dynamic response = await _apiServices.getGetApiResponse(
//           AppUrl.paymentHistoryUrl + '?CustomerToken=' + token.toString());
//       return response = PaymentHistoryModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }
// }
