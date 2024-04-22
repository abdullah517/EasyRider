// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Methods/geofireassistant.dart';
import 'package:ridemate/Providers/homeprovider.dart';
import 'package:ridemate/Providers/useraddressprovider.dart';
import 'package:ridemate/models/directiondetails.dart';
import 'package:ridemate/models/nearbyavailabledrivers.dart';
import 'package:ridemate/utils/api_credential.dart';
import 'package:image/image.dart' as images;
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
    final direction = Provider.of<Homeprovider>(context, listen: false);
    markers.removeWhere((element) => element.markerId.value == '1');
    markers.add(
      Marker(
        markerId: const MarkerId('3'),
        position: LatLng(destination.latitude, destination.longitude),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId('2'),
        position: LatLng(pickup.latitude, pickup.longitude),
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
        direction.directiondetails = directiondetails;
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
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 140));
    direction.calculatefare();
  }

  Future<LocationData> getUserCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return Future.error('Location permissions are denied');
    }

    locationData = await location.getLocation();
    return locationData;
  }

  void setposition(BuildContext context) {
    getUserCurrentLocation().then((value) async {
      Provider.of<Homeprovider>(context, listen: false)
          .convertlatlngtoaddress(value);
      Provider.of<Pickupaddress>(context, listen: false)
          .updateaddress(value.latitude!, value.longitude!);
      Uint8List imagebyte = await makeReceiptImage();
      markers.add(
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(value.latitude!, value.longitude!),
          infoWindow: const InfoWindow(title: 'userlocation'),
          icon: BitmapDescriptor.fromBytes(imagebyte),
        ),
      );
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude!, value.longitude!), zoom: 14.4746);
      final GoogleMapController googleMapController = await controller.future;
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      notifyListeners();
      initGeofirelistener(context);
    });
  }

  void initGeofirelistener(BuildContext context) {
    final currentpos = Provider.of<Pickupaddress>(context, listen: false);
    Geofire.initialize('availableDrivers');
    Geofire.queryAtLocation(currentpos.latitude, currentpos.longitude, 10)!
        .listen((map) {
      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack) {
          case Geofire.onKeyEntered:
            final nearbyavailabledrivers = Nearbyavailabledrivers(
              key: map['key'],
              latitude: map['latitude'],
              longitude: map['longitude'],
            );
            Geofireassistant.nearbyavailabledriverslist
                .add(nearbyavailabledrivers);
            break;

          case Geofire.onKeyExited:
            Geofireassistant.removedriverfromlist(map['key']);
            removedriveronmap(map['key']);
            break;

          case Geofire.onKeyMoved:
            final nearbyavailabledrivers = Nearbyavailabledrivers(
              key: map['key'],
              latitude: map['latitude'],
              longitude: map['longitude'],
            );
            Geofireassistant.updatedriverlocation(nearbyavailabledrivers);
            updatedriversonmap();
            break;

          case Geofire.onGeoQueryReady:
            updatedriversonmap();
            break;
        }
      }
    });
  }

  void removedriveronmap(String key) {
    markers.removeWhere((element) => element.markerId.value == 'driver$key');
    notifyListeners();
  }

  void updatedriversonmap() async {
    ByteData imageData = await rootBundle.load('assets/mapcar.png');
    var bytes = Uint8List.view(imageData.buffer);
    var carmapimg = images.decodeImage(bytes);
    carmapimg = images.copyResize(carmapimg!, height: 100, width: 100);
    var bytedata = images.encodePng(carmapimg);
    for (Nearbyavailabledrivers driver
        in Geofireassistant.nearbyavailabledriverslist) {
      markers.removeWhere(
          (element) => element.markerId.value == 'driver${driver.key}');
    }
    for (Nearbyavailabledrivers driver
        in Geofireassistant.nearbyavailabledriverslist) {
      Marker marker = Marker(
        markerId: MarkerId('driver${driver.key}'),
        position: LatLng(driver.latitude, driver.longitude),
        rotation: Random().nextInt(360).toDouble(),
        icon: BitmapDescriptor.fromBytes(bytedata),
      );
      markers.add(marker);
    }
    notifyListeners();
  }
}
