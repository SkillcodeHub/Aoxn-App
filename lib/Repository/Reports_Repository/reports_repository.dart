import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/Reports_Model/reports_model.dart';
import '../../Res/app_url.dart';

class ReportsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ReportsListModel> fetchReportsList(String token, String mobile) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getrxvisithistoryUrl +
              '?CustomerToken=' +
              token.toString() +
              "&Mobile=" +
              "8140629967");
      return response = ReportsListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
