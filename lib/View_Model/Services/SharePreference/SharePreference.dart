import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<String?> getMobile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_mobile");
  }

  void setMobile(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_mobile", args);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_token");
  }

  void setToken(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", args);
  }

  void logoutProcess() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove("isLoggedIn");
    // prefs.remove("loginInfo");
    prefs.remove("access_mobile");
    prefs.remove("access_token");
    prefs.remove("myList");
    // prefs.remove("access_doctor");
  }

  // Save the list to SharedPreferences
  Future<void> saveListToSharedPreferences(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('myList', list);
  }

// Retrieve the list from SharedPreferences
  Future<List<String>> getListFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList('myList');
    return list ?? [];
  }
}
