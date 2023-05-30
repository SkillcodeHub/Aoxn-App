import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Model/DoctorDetails_Model/doctordetails_model.dart';
import '../../Res/app_url.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';

class SettingsRepository {
  BaseApiServices _apiServices = NetworkApiService();
  UserPreferences userPreference = UserPreferences();
  String? token;
  Future<DoctorDetailsListModel> fetchDoctorDetailsList() async {
    userPreference.getToken().then((value1) {
      token = value1;
    });
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getdoctordetailsUrl +
              '?CustomerToken=' +
              '68cb311f-585a-4e86-8e89-06edf1814080');
      print(response);
      return response = DoctorDetailsListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
