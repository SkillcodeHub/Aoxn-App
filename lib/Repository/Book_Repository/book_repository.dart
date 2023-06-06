import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/DoctorList_Model/doctorlist_model.dart';
import '../../Res/app_url.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';

class DoctorListRepository {
  BaseApiServices _apiServices = NetworkApiService();
  UserPreferences userPreference = UserPreferences();
  Future<DoctorListModel> fetchDoctorList(token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getdoctorUrl + '?CustomerToken=' + token.toString());
      print(response);
      return response = DoctorListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
