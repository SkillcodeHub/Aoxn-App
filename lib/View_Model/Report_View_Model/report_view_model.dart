import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Model/Reports_Model/reports_model.dart';
import '../../Repository/Reports_Repository/reports_repository.dart';

class ReportViewmodel with ChangeNotifier {
  final _myRepo = ReportsRepository();
  ApiResponse<ReportsListModel> reportsList = ApiResponse.loading();
  setReportsList(ApiResponse<ReportsListModel> response) {
    reportsList = response;
    notifyListeners();
  }

  Future<void> fetchReportsListApi(String token, String mobile) async {
    setReportsList(ApiResponse.loading());
    _myRepo.fetchReportsList(token, mobile).then((value) {
      setReportsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setReportsList(ApiResponse.error(error.toString()));
    });
  }
}
