import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/useraddressprovider.dart';
import 'package:ridemate/models/directiondetails.dart';
import 'package:ridemate/utils/api_credential.dart';

class Mapprovider extends ChangeNotifier {
  List<LatLng> plineCoordinates = [];
  Set<Polyline> polylineset = {};
  Future<void> obtainplacedirection(BuildContext context) async {
    final pickup = Provider.of<Pickupaddress>(context, listen: false);
    final destination = Provider.of<Destinationaddress>(context, listen: false);
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?destination=${destination.latitude},${destination.longitude}&origin=${pickup.latitude},${pickup.longitude}&key=$mapapikey';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['status'] == 'OK') {
        Directiondetails directiondetails = Directiondetails(
          distancevalue: res['routes'][0]['legs'][0]['distance']['value'],
          distancetext: res['routes'][0]['legs'][0]['distance']['text'],
          durationtext: res['routes'][0]['legs'][0]['duration']['text'],
          durationvalue: res['routes'][0]['legs'][0]['duration']['value'],
          encodedpoints: res['routes'][0]['overview_polyline']['points'],
        );
        PolylinePoints polylinePoints = PolylinePoints();
        List<PointLatLng> decodedPolylinePointsResult =
            polylinePoints.decodePolyline(directiondetails.encodedpoints);
        plineCoordinates.clear();
        if (decodedPolylinePointsResult.isNotEmpty) {
          for (var pointLatLng in decodedPolylinePointsResult) {
            plineCoordinates
                .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
          }
        }
        Polyline polyline = Polyline(
          polylineId: const PolylineId('polylineid'),
          color: Colors.pink,
          jointType: JointType.round,
          points: plineCoordinates,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true,
        );
        polylineset.clear();
        polylineset.add(polyline);
        notifyListeners();
      }
    }
  }
}
