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
              '9549a931-ad43-11e9-8427-02a80849fdb4' +
              "&Mobile=" +
              "8140629967");
      return response = ReportsListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
