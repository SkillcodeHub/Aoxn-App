import 'package:flutter/material.dart';

class ButtonProvider with ChangeNotifier {
  bool _backk = false;
  bool get backk => _backk;

  setBack(bool value) {
    _backk = value;
    notifyListeners();
  }
}
