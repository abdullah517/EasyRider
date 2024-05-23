import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/customappbar.dart';

class LiveLocation extends StatefulWidget {
  final String bookingId;

  const LiveLocation({Key? key, required this.bookingId}) : super(key: key);

  @override
  State<LiveLocation> createState() => _LivelocationmapState();
}

class _LivelocationmapState extends State<LiveLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  late StreamSubscription<DocumentSnapshot> _subscription;
  LatLng _liveLocation = const LatLng(0, 0);
  LatLng _startLocation = const LatLng(0, 0);
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _startLiveLocationUpdates();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _startLiveLocationUpdates() {
    FirebaseFirestore.instance
        .collection('booking')
        .doc(widget.bookingId)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        var location = snapshot['livelocation'].split(', ');
        double lat = double.parse(location[0]);
        double lng = double.parse(location[1]);
        setState(() {
          _liveLocation = LatLng(lat, lng);
        });

        var startLocation = snapshot['userstartlocation'];
        lat = startLocation['latitude'];
        lng = startLocation['longitude'];
        setState(() {
          _startLocation = LatLng(lat, lng);
        });

        _updatePath();
      }
    });

    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      FirebaseFirestore.instance
          .collection('booking')
          .doc(widget.bookingId)
          .get()
          .then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          var location = snapshot['livelocation'].split(', ');
          double lat = double.parse(location[0]);
          double lng = double.parse(location[1]);
          setState(() {
            _liveLocation = LatLng(lat, lng);
          });

          _updatePath();
        }
      });
    });
  }

  void _updatePath() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDoCmnLSTMCBPnbqrG3_71ZztjLItFsnfk',
      PointLatLng(_startLocation.latitude, _startLocation.longitude),
      PointLatLng(_liveLocation.latitude, _liveLocation.longitude),
    );

    List<LatLng> polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      // Use a for loop instead of forEach
      for (PointLatLng point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    Polyline polyline = Polyline(
      polylineId: const PolylineId('poly'),
      color: Appcolors.primaryColor,
      points: polylineCoordinates,
      width: 3,
    );

    setState(() {
      _polylines.clear();
      _polylines.add(polyline);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: customappbar(context,
            title: 'Bookings', backgroundColor: Appcolors.primaryColor),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _liveLocation,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('liveLocation'),
                  position: _liveLocation,
                  infoWindow: const InfoWindow(
                    title: 'Live Location',
                    snippet: 'Your live location',
                  ),
                ),
                Marker(
                  markerId: const MarkerId('startLocation'),
                  position: _startLocation,
                  infoWindow: const InfoWindow(
                    title: 'Start Location',
                    snippet: 'Your start location',
                  ),
                ),
              },
              polylines: _polylines,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              compassEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
