import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _obscuretext = true;
  bool get visibility => _obscuretext;
  void changevisibility() {
    _obscuretext = !_obscuretext;
    notifyListeners();
  }
}
