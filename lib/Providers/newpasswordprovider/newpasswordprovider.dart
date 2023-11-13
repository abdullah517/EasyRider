import 'package:flutter/material.dart';

class Newpasswordprovider extends ChangeNotifier {
  bool _obscuretext1 = true;
  bool _obscuretext2 = true;
  bool get visibility1 => _obscuretext1;
  bool get visibility2 => _obscuretext2;
  void changevisibility1() {
    _obscuretext1 = !_obscuretext1;
    notifyListeners();
  }

  void changevisibility2() {
    _obscuretext2 = !_obscuretext2;
    notifyListeners();
  }
}
