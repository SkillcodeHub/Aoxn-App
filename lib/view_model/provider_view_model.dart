import 'package:axonweb/Model/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetProviderTokenViewModel with ChangeNotifier {
  Future<bool> saveProviderToken(GetProviderTokenModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.displayMessage.toString());
    notifyListeners();
    return true;
  }

  Future<GetProviderTokenModel> getProviderToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');

    return GetProviderTokenModel(
      displayMessage: token.toString(),
    );
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}
