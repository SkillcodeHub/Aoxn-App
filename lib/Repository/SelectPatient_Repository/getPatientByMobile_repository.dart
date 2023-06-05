import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/SelectPatient_Model/getPatientByMobile_model.dart';
import '../../Res/app_url.dart';

class GetPatientByMobileRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<GetPatientByMobileModel> fetchGetPatientByMobileList() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getpatientbymobile + "?Mobile=" + "7567444375");
      print(response);
      return response = GetPatientByMobileModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
