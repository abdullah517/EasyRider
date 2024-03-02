import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ridemate/models/placepredmodel.dart';
import 'package:ridemate/utils/api_credential.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Homeprovider extends ChangeNotifier {
  bool showicon = false;
  List<Placepredmodel> suggestionlist = [];
  String message = '';
  String address = '';
  String destination = 'Destination';

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

  void changedest(String dest) {
    destination = dest;
    notifyListeners();
  }

  Future<void> convertlatlngtoaddress(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    address =
        "${placemarks.reversed.last.street}(${placemarks.reversed.last.subLocality})";
    notifyListeners();
  }

  Future<void> getsuggesstion(String input) async {
    String baseurl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String sessiontoken = const Uuid().v4();
    String request =
        '$baseurl?input=$input&key=$mapapikey&sessiontoken=$sessiontoken&components=country:pk';

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        message = '';
        List predictions = result['predictions'];
        suggestionlist =
            (predictions).map((j) => Placepredmodel.fromjson(j)).toList();
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
