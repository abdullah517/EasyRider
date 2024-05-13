import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/driverrideprovider.dart';
import 'package:ridemate/models/ridedetails.dart';

class DriverRideScreen extends StatelessWidget {
  final RideDetails rideDetails;
  DriverRideScreen({super.key, required this.rideDetails});
  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(33.6941, 72.9734), zoom: 14.4746);
  final Completer<GoogleMapController> mapcontroller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<DriverRideProivder>(
            builder: (context, value, child) => GoogleMap(
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) {
                mapcontroller.complete(controller);
                value.newgooglemapcontroller = controller;
                value.getcurrentLocation(rideDetails.rideid).then((loc) async {
                  var currentLatLng = LatLng(loc.latitude!, loc.longitude!);
                  var pickupLatLng = rideDetails.pickup;
                  await value.getPlaceDirection(currentLatLng, pickupLatLng);
                  value.animatedrivercar(rideDetails.rideid);
                });
              },
              markers: Set<Marker>.of(value.markersSet),
              polylines: value.polylineset,
            ),
          )
        ],
      ),
    );
  }
}
