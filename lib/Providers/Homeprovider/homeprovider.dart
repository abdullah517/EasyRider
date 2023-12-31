import 'package:flutter/material.dart';

class Homeprovider extends ChangeNotifier {
  int currentpage = 0;
  void changecurrentpage(int index) {
    currentpage = index;
    notifyListeners();
  }
}
