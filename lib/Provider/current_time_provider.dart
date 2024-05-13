import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeProvider with ChangeNotifier {
  String _currentTime = '';

  String get currentTime => _currentTime;

  void updateTime() {
    DateTime now = DateTime.now();
    DateFormat timeFormat = DateFormat('hh:mm:ss a');
    _currentTime = timeFormat.format(now);
    notifyListeners();
  }
}
