import 'package:flutter/material.dart';

class Onboardingprovider extends ChangeNotifier {
  double progressvalue = 0.7;

  void setprogressvalue(int index) {
    if (index == 1) {
      progressvalue = 0.35;
    } else if (index == 2) {
      progressvalue = 0;
    } else {
      progressvalue = 0.7;
    }
    notifyListeners();
  }
}
