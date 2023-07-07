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

  Future<String?> getDeviceId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_deviceId");
  }

  void setDeviceId(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_deviceId", args);
  }

  Future<String?> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_name");
  }

  void setName(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_name", args);
  }

  Future<String?> getAge() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_age");
  }

  void setAge(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_age", args);
  }

  Future<String?> getletId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_letId");
  }

  void setletId(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_letId", args);
  }

  Future<String?> getKeyForCallLetIdApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_keyforcallletidapi");
  }

  void setKeyForCallLetIdApi(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_keyforcallletidapi", args);
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

  void saveDataToSharedPreferences(List<Map<String, dynamic>> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the data list to a JSON string
    String jsonString = jsonEncode(data);

    // Save the JSON string to SharedPreferences
    await prefs.setString('data', jsonString);
  }

  Future<List<Map<String, dynamic>>?> getDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the JSON string from SharedPreferences
    String? jsonString = prefs.getString('data');

    if (jsonString != null) {
      // Convert the JSON string back to a List<Map<String, dynamic>>
      List<dynamic> jsonData = jsonDecode(jsonString);

      // Map each dynamic item to a Map<String, dynamic> and return the result
      return jsonData.map((item) => item as Map<String, dynamic>).toList();
    }

    return []; // Return null if no data is found in SharedPreferences
  }


void saveUserData(Map<String, dynamic> userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userData', jsonEncode(userData));
}

Future<Map<String, dynamic>?> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userDataString = prefs.getString('userData');
  if (userDataString != null) {
    Map<String, dynamic> userData = jsonDecode(userDataString);
    return userData;
  } else {
    return null;
  }
}



void logoutProcess() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove("isLoggedIn");
    // prefs.remove("loginInfo");
    prefs.remove("access_mobile");
    prefs.remove("access_token");
    prefs.remove("data");
    prefs.remove("access_keyforcallletidapi");

       

    // prefs.remove("access_doctor");
  }

}
