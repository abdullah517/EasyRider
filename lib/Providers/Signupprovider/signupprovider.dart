import 'package:flutter/material.dart';

class Signupprovider extends ChangeNotifier {
  bool? ischecked = true;
  void setcheckstate(bool? value) {
    ischecked = value;
    notifyListeners();
  }
}
