import 'dart:async';
import 'dart:convert';
import 'package:image/image.dart' as images;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:ridemate/utils/appcolors.dart';
import '../models/directiondetails.dart';
import '../utils/api_credential.dart';

class DriverRideProivder extends ChangeNotifier {
  final Set<Marker> markersSet = <Marker>{};
  final Set<Polyline> polylineset = {};
  final List<LatLng> plineCoordinates = [];
  late final GoogleMapController newgooglemapcontroller;
  late StreamSubscription<LocationData> ridestreamsubscription;

  Future<LocationData> getcurrentLocation() async {
    Location location = Location();
    LocationData locationData = await location.getLocation();
    return locationData;
  }

  Future<void> getPlaceDirection(
      LatLng pickUpLatLng, LatLng dropoffLatLng) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?destination=${dropoffLatLng.latitude},${dropoffLatLng.longitude}&origin=${pickUpLatLng.latitude},${pickUpLatLng.longitude}&key=$mapapikey';
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
          color: Appcolors.primaryColor,
          jointType: JointType.round,
          points: plineCoordinates,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true,
        );
        polylineset.clear();
        polylineset.add(polyline);
        LatLngBounds latLngBounds;
        if (pickUpLatLng.latitude > dropoffLatLng.latitude &&
            pickUpLatLng.longitude > dropoffLatLng.longitude) {
          latLngBounds = LatLngBounds(
            southwest: LatLng(dropoffLatLng.latitude, dropoffLatLng.longitude),
            northeast: LatLng(pickUpLatLng.latitude, pickUpLatLng.longitude),
          );
        } else if (pickUpLatLng.longitude > dropoffLatLng.longitude) {
          latLngBounds = LatLngBounds(
            southwest: LatLng(pickUpLatLng.latitude, dropoffLatLng.longitude),
            northeast: LatLng(dropoffLatLng.latitude, pickUpLatLng.longitude),
          );
        } else if (pickUpLatLng.latitude > dropoffLatLng.latitude) {
          latLngBounds = LatLngBounds(
            southwest: LatLng(dropoffLatLng.latitude, pickUpLatLng.longitude),
            northeast: LatLng(pickUpLatLng.latitude, dropoffLatLng.longitude),
          );
        } else {
          latLngBounds = LatLngBounds(
            southwest: LatLng(pickUpLatLng.latitude, pickUpLatLng.longitude),
            northeast: LatLng(dropoffLatLng.latitude, dropoffLatLng.longitude),
          );
        }
        newgooglemapcontroller
            .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 140));
        Marker pickuplocmarker = Marker(
          markerId: const MarkerId('pickup'),
          position: pickUpLatLng,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        );
        Marker destlocmarker = Marker(
          markerId: const MarkerId('dest'),
          position: dropoffLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
        markersSet.add(pickuplocmarker);
        markersSet.add(destlocmarker);
        notifyListeners();
      }
    }
  }

  Future<void> animatedrivercar() async {
    Location location = Location();
    ByteData imageData = await rootBundle.load('assets/mapcar.png');
    var bytes = Uint8List.view(imageData.buffer);
    var carmapimg = images.decodeImage(bytes);
    carmapimg = images.copyResize(carmapimg!, height: 100, width: 100);
    var bytedata = images.encodePng(carmapimg);
    ridestreamsubscription = location.onLocationChanged.listen((pos) {
      LatLng newpos = LatLng(pos.latitude!, pos.longitude!);
      Marker animatingmarker = Marker(
        markerId: const MarkerId('animating'),
        position: newpos,
        infoWindow: const InfoWindow(title: 'currentlocation'),
        icon: BitmapDescriptor.fromBytes(bytedata),
      );
      CameraPosition cameraPosition = CameraPosition(target: newpos, zoom: 17);
      newgooglemapcontroller
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      markersSet
          .removeWhere((element) => element.markerId.value == 'animating');
      markersSet.add(animatingmarker);
      notifyListeners();
    });
  }
}
