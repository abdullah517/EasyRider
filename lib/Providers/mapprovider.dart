import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/homeprovider.dart';
import 'package:ridemate/Providers/useraddressprovider.dart';
import 'package:ridemate/models/directiondetails.dart';
import 'package:ridemate/utils/api_credential.dart';

import '../view/Homepage/homepage.dart';

class Mapprovider extends ChangeNotifier {
  List<LatLng> plineCoordinates = [];
  Set<Polyline> polylineset = {};
  late GoogleMapController newgooglemapcontroller;
  final Set<Marker> markers = {};
  final Completer<GoogleMapController> controller = Completer();
  Future<void> obtainplacedirection(BuildContext context) async {
    final pickup = Provider.of<Pickupaddress>(context, listen: false);
    final destination = Provider.of<Destinationaddress>(context, listen: false);
    markers.add(
      Marker(
        markerId: const MarkerId('3'),
        position: LatLng(destination.latitude, destination.longitude),
      ),
    );
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
    LatLngBounds latLngBounds;
    if (pickup.latitude > destination.latitude &&
        pickup.longitude > destination.longitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(destination.latitude, destination.longitude),
        northeast: LatLng(pickup.latitude, pickup.longitude),
      );
    } else if (pickup.longitude > destination.longitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(pickup.latitude, destination.longitude),
        northeast: LatLng(destination.latitude, pickup.longitude),
      );
    } else if (pickup.latitude > destination.latitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(destination.latitude, pickup.longitude),
        northeast: LatLng(pickup.latitude, destination.longitude),
      );
    } else {
      latLngBounds = LatLngBounds(
        southwest: LatLng(pickup.latitude, pickup.longitude),
        northeast: LatLng(destination.latitude, destination.longitude),
      );
    }
    newgooglemapcontroller
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
  }

  Future<Position> getuserCurrentLocation() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition();
  }

  void setposition(BuildContext context) {
    getuserCurrentLocation().then((value) async {
      Provider.of<Homeprovider>(context, listen: false)
          .convertlatlngtoaddress(value);
      Provider.of<Pickupaddress>(context, listen: false)
          .updateaddress(value.latitude, value.longitude);
      Uint8List imagebyte = await makeReceiptImage();
      markers.add(
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'userlocation'),
          icon: BitmapDescriptor.fromBytes(imagebyte),
        ),
      );
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14.4746);
      final GoogleMapController googleMapController = await controller.future;
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      notifyListeners();
    });
  }
}
