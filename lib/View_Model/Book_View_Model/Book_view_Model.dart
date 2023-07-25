import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Model/DoctorList_Model/doctorlist_model.dart';
import '../../Repository/Book_Repository/book_repository.dart';

class DoctorListViewmodel with ChangeNotifier {
  final _myRepo = DoctorListRepository();
  ApiResponse<DoctorListModel> doctorList = ApiResponse.loading();
  setDoctorList(ApiResponse<DoctorListModel> response) {
    doctorList = response;
    print(doctorList);
    notifyListeners();
  }

  late String _selectedDoctorId;

  String get selectedDoctorId => _selectedDoctorId;

  set selectedDoctorId(String newValue) {
    _selectedDoctorId = newValue;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchDoctorListApi(String token) async {
    setDoctorList(ApiResponse.loading());
    _myRepo.fetchDoctorList(token).then((value) {
      setDoctorList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDoctorList(ApiResponse.error(error.toString()));
    });
  }
}

class DoctorNameProvider extends ChangeNotifier {
  String doctorName = ' ';
  String doctorId = '0';

  Future<void> updateTextValues(String doctorname, String doctorid) async {
    doctorName = doctorname;
    doctorId = doctorid;
    notifyListeners();
    await Future.delayed(Duration.zero);
  }

  void resetData() {
    doctorName = ' '; // Set default doctorName value here
    doctorId = '0'; // Set default doctorid value here
    notifyListeners();
  }
}
