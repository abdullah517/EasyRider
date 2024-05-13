import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as images;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ridemate/Methods/mapmethods.dart';
import 'package:ridemate/utils/appcolors.dart';
import '../models/directiondetails.dart';

class DriverRideProivder extends ChangeNotifier {
  final Set<Marker> markersSet = <Marker>{};
  final Set<Polyline> polylineset = {};
  final List<LatLng> plineCoordinates = [];
  late final GoogleMapController newgooglemapcontroller;
  late StreamSubscription<LocationData> ridestreamsubscription;

  Future<LocationData> getcurrentLocation(String rideid) async {
    Location location = Location();
    LocationData locationData = await location.getLocation();

    FirebaseFirestore.instance.collection('RideRequest').doc(rideid).set({
      'driver_loc': {
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
      },
    }, SetOptions(merge: true));
    return locationData;
  }

  Future<void> getPlaceDirection(
      LatLng pickUpLatLng, LatLng dropoffLatLng) async {
    Directiondetails directiondetails =
        await fetchDirectionDetails(pickUpLatLng, dropoffLatLng);

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

    LatLngBounds latLngBounds = createLatLngBounds(
      pickUpLatLng,
      dropoffLatLng,
    );

    newgooglemapcontroller
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 140));
    Marker pickuplocmarker = Marker(
      markerId: const MarkerId('pickup'),
      position: pickUpLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
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

  Future<void> animatedrivercar(String rideid) async {
    Location location = Location();
    ByteData imageData = await rootBundle.load('assets/mapcar.png');
    var bytes = Uint8List.view(imageData.buffer);
    var carmapimg = images.decodeImage(bytes);
    carmapimg = images.copyResize(carmapimg!, height: 100, width: 100);
    var bytedata = images.encodePng(carmapimg);
    ridestreamsubscription = location.onLocationChanged.listen((pos) {
      FirebaseFirestore.instance.collection('RideRequest').doc(rideid).update({
        'driver_loc': {
          'latitude': pos.latitude,
          'longitude': pos.longitude,
        },
      });
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
