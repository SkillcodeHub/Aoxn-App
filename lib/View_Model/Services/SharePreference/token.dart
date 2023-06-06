import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/CustomerToken_Model/customer_token.dart';

class GetTokenViewModel with ChangeNotifier {
  Future<bool> saveProviderToken(CustomerTokenModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.data!.token.toString());
    notifyListeners();
    return true;
  }

  Future<CustomerTokenModel> getProviderToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');

    return CustomerTokenModel(
      displayMessage: token.toString(),
    );
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}
