import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Homeprovider extends ChangeNotifier {
  int currentpage = 0;
  bool showicon = false;
  List suggestionlist = [];
  String message = '';
  void changecurrentpage(int index) {
    currentpage = index;
    notifyListeners();
  }

  void changeiconvisibility(int length) {
    if (length > 0) {
      showicon = true;
      notifyListeners();
    } else {
      showicon = false;
      suggestionlist = [];
      notifyListeners();
    }
  }

  Future<void> getsuggesstion(String input) async {
    String apikey = 'AIzaSyDoCmnLSTMCBPnbqrG3_71ZztjLItFsnfk';
    String baseurl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String sessiontoken = const Uuid().v4();
    String request =
        '$baseurl?input=$input&key=$apikey&sessiontoken=$sessiontoken&components=country:pk';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        message = '';
        suggestionlist =
            result['predictions'].map((p) => p['description']).toList();
        notifyListeners();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        message = 'nothingfound';
        notifyListeners();
      }
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
