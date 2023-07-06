import 'dart:async';
import 'package:axonweb/data/response/api_response.dart';
import 'package:flutter/material.dart';
import '../../Model/News_Model/news_model.dart';
import '../../Repository/News_Repository/repository.dart';

class NewsViewmodel with ChangeNotifier {
  final _myRepo = NewsRepository();
  ApiResponse<NewsListModel> newsList = ApiResponse.loading();
  setNewsList(ApiResponse<NewsListModel> response) {
    newsList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchNewsListApi(String token, String letId) async {
    setNewsList(ApiResponse.loading());
    _myRepo.fetchNewsList(token,letId).then((value) {
      setNewsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setNewsList(ApiResponse.error(error.toString()));
    });
  }
}

// class CustomerTkenViewmodel with ChangeNotifier {
//   UserPreferences userPreference = UserPreferences();

//   final _myRepo = ChangeProviderRepository();
//   ApiResponse<CustomerTokenModel> customertoken = ApiResponse.loading();
//   setCustomerToken(ApiResponse<CustomerTokenModel> response) {
//     customertoken = response;
//     print(customertoken);
//     notifyListeners();
//   }

//   Future<void> fetchCustomerTokenApi(context, String appCode) async {
//     // List<String> myList = [];

//     setCustomerToken(ApiResponse.loading());
//     _myRepo.fetchCustomerToken(appCode).then((value) {
//       setCustomerToken(ApiResponse.completed(value));

//       final token = customertoken.data!.data!.token.toString();
//       print(token);
//       userPreference.setToken(token);
//       void main() async {
//         // Retrieve the list
//         List<String> retrievedList =
//             await userPreference.getListFromSharedPreferences();
//         print('Retrieved list from SharedPreferences:');
//         print(retrievedList);
//         retrievedList.add(appCode);
//         Set<String> uniqueItems = Set<String>.from(retrievedList);
//         print(uniqueItems.toList());
//         await userPreference.saveListToSharedPreferences(uniqueItems.toList());
//       }

//       main();

//       Timer(
//           Duration(seconds: 1),
//           () => Navigator.push(context,
//               MaterialPageRoute(builder: (context) => MyNavigationBar())));
//     }).onError((error, stackTrace) {
//       setCustomerToken(ApiResponse.error(error.toString()));
//     });
//   }
// }
