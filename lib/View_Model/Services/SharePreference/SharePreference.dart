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
    prefs.remove("data");
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
}






// class SharedPreferencesHelper {
//   static const String _dataKey = 'data';

//   // Store data in shared preferences
//   static Future<void> saveData(List<Map<String, String>> data) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> jsonData = data.map((item) => json.encode(item)).toList();
//     await prefs.setStringList(_dataKey, jsonData);
//   }

//   // Retrieve data from shared preferences
//   static Future<List<Map<String, String>>> getData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? jsonData = prefs.getStringList(_dataKey);
//     List<Map<String, String>> data = jsonData
//             ?.map((item) => json.decode(item))
//             .cast<Map<String, String>>()
//             .toList() ??
//         [];
//     return data;
//   }
// }




// class SharedPreferencesHelper {
//   static const String _dataKey = 'data';

//   // Store data in shared preferences
//   static Future<void> saveData(List<Map<String, String>> data) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> jsonData = data.map((item) => json.encode(item)).toList();
//     await prefs.setStringList(_dataKey, jsonData);
//   }

//   // Retrieve data from shared preferences
//   static Future<List> getData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? jsonData = prefs.getStringList(_dataKey);
//     List data = jsonData?.map((item) => json.decode(item)).toList() ?? [];
//     return data;
//   }
// }
