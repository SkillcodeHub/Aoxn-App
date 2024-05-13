import 'dart:async';

import 'package:axonweb/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
    setCustomerToken(ApiResponse.loading());
    _myRepo.fetchCustomerToken(appCode).then((value) {
      setCustomerToken(ApiResponse.completed(value));
      if (value.status == false) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Center(
                  child: Text(
                    'Alert!',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                content: Text(
                  value.messageCode.toString(),
                  style: TextStyle(fontSize: 12.sp),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  SizedBox(
                    width: 80.w,
                    child: ElevatedButton(
                      child: Text(
                        'OK',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              );
            });
      }

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
      if (value.status == true) {
        Timer(
            Duration(seconds: 0),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyNavigationBar(
                          indexNumber: 0,
                        ))));
      } else if (value.status == false) {
        Utils.flushBarErrorMessage(
            'OTP Send Successfully', Duration(seconds: 2), context);
      }
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
