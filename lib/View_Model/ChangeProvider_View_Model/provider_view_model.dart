import 'dart:async';

import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Model/CustomerToken_Model/customer_token.dart';
import '../../Repository/Change_Provider_Repository/change_provider_repository.dart';
import '../../View/NevigationBar/my_navigationbar.dart';
import '../Services/SharePreference/SharePreference.dart';

class CustomerTkenViewmodel with ChangeNotifier {
  UserPreferences userPreference = UserPreferences();

  final _myRepo = ChangeProviderRepository();
  ApiResponse<CustomerTokenModel> customertoken = ApiResponse.loading();
  setCustomerToken(ApiResponse<CustomerTokenModel> response) {
    customertoken = response;
    print(customertoken);
    notifyListeners();
  }

  bool _backButton = false;
  bool get backButton => _backButton;
  setBackButton(bool value) {
    _backButton = value;
    notifyListeners();
  }

  Future<void> fetchCustomerTokenApi(context, String appCode) async {
    // List<String> myList = [];

    setCustomerToken(ApiResponse.loading());
    _myRepo.fetchCustomerToken(appCode).then((value) {
      setCustomerToken(ApiResponse.completed(value));

      final token = customertoken.data!.data!.token.toString();
      print(token);
      userPreference.setToken(token);
      void main() async {
        // Retrieve the list
        List<String> retrievedList =
            await userPreference.getListFromSharedPreferences();
        print('Retrieved list from SharedPreferences:');
        print(retrievedList);
        retrievedList.add(appCode);
        Set<String> uniqueItems = Set<String>.from(retrievedList);
        print(uniqueItems.toList());
        await userPreference.saveListToSharedPreferences(uniqueItems.toList());
      }

      main();

      Timer(
          Duration(seconds: 1),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyNavigationBar(
                        indexNumber: 0,
                      ))));
    }).onError((error, stackTrace) {
      setCustomerToken(ApiResponse.error(error.toString()));
    });
  }
}

class CustomerTokenByQRViewmodel with ChangeNotifier {
  UserPreferences userPreference = UserPreferences();

  final _myRepo = ChangeProviderRepository();
  ApiResponse<CustomerTokenModel> customertoken = ApiResponse.loading();
  setCustomerToken(ApiResponse<CustomerTokenModel> response) {
    customertoken = response;
    print(customertoken);
    notifyListeners();
  }

  Future<void> fetchCustomerTokenByQR(context, String appCode) async {
    // List<String> myList = [];

    setCustomerToken(ApiResponse.loading());
    _myRepo.fetchCustomerTokenByQR(appCode).then((value) {
      setCustomerToken(ApiResponse.completed(value));

      final token = customertoken.data!.data!.token.toString();
      print(token);
      userPreference.setToken(token);
      void main() async {
        // Retrieve the list
        List<String> retrievedList =
            await userPreference.getListFromSharedPreferences();
        print('Retrieved list from SharedPreferences:');
        print(retrievedList);
        retrievedList.add(appCode);
        Set<String> uniqueItems = Set<String>.from(retrievedList);
        print(uniqueItems.toList());
        await userPreference.saveListToSharedPreferences(uniqueItems.toList());
      }

      main();

      Timer(
          Duration(seconds: 1),
          () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MyNavigationBar(
                        indexNumber: 0,
                      )),
              (route) => false));
    }).onError((error, stackTrace) {
      setCustomerToken(ApiResponse.error(error.toString()));
    });
  }
}














































































// import 'package:axonweb/Model/provider_model.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GetProviderTokenViewModel with ChangeNotifier {
//   Future<bool> saveProviderToken(GetProviderTokenModel user) async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.setString('token', user.displayMessage.toString());
//     notifyListeners();
//     return true;
//   }

//   Future<GetProviderTokenModel> getProviderToken() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     final String? token = sp.getString('token');

//     return GetProviderTokenModel(
//       displayMessage: token.toString(),
//     );
//   }

//   Future<bool> remove() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.remove('token');
//     return true;
//   }
// }
