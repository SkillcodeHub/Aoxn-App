// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class CurrentTimeProvider with ChangeNotifier {
//   double indicatorValue = 0.0;
//   Timer? timer;

//   String time() {
//     return "${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour} : ${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} : ${DateTime.now().second < 10 ? "0${DateTime.now().second}" : DateTime.now().second} ";
//   }

//   void updateSeconds() {
//     timer = Timer.periodic(
//       Duration(seconds: 1),
//       (Timer timer) {
//         indicatorValue = DateTime.now().second / 60;
//         notifyListeners();
//       },
//     );
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeProvider with ChangeNotifier {
  String _currentTime = '';

  String get currentTime => _currentTime;

  // void updateTime() {
  //   // DateTime now = DateTime.now();
  //   DateFormat.yMEd().add_jms().format(DateTime.now());

  //   _currentTime =
  //       "${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour} : ${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} : ${DateTime.now().second < 10 ? "0${DateTime.now().second}" : DateTime.now().second} ";
  //   notifyListeners();
  // }
  void updateTime() {
    DateTime now = DateTime.now();
    DateFormat timeFormat = DateFormat('hh:mm:ss a');
    _currentTime = timeFormat.format(now);
    notifyListeners();
  }
}

    // _currentTime = '${now.hour}:${now.minute}:${now.second}';
//  + ${DateFormat.yMEd().add_jms().format(DateTime.now())} 