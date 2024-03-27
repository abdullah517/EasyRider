// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Methods/geofireassistant.dart';
import 'package:ridemate/Providers/homeprovider.dart';
import 'package:ridemate/Providers/useraddressprovider.dart';
import 'package:ridemate/Providers/userdataprovider.dart';
import 'package:ridemate/models/nearbyavailabledrivers.dart';
import 'package:ridemate/services/pushnotificationservice.dart';

class Bookingprovider extends ChangeNotifier {
  void saveRideRequest(BuildContext context) {
    final firestore = FirebaseFirestore.instance.collection('Ride Requests');
    final pickup = Provider.of<Pickupaddress>(context, listen: false);
    final destination = Provider.of<Destinationaddress>(context, listen: false);
    final address = Provider.of<Homeprovider>(context, listen: false);
    final user = Provider.of<Userdataprovider>(context, listen: false);
    firestore.doc().set({
      'driver_id': 'waiting',
      'pickup': {
        'latitude': pickup.latitude,
        'longitude': pickup.longitude,
      },
      'dropoff': {
        'latitude': destination.latitude,
        'longitude': destination.longitude,
      },
      'created_at': DateTime.now(),
      'rider_name': user.userData['Username'],
      'pickup_address': address.address,
      'destination_address': address.destination,
    });
  }

  void initfcm(String token) async {
    PushNotificationService service = PushNotificationService();
    await service.init().then((value) async {
      await service.sendNotification(token);
    });
  }

  Future<void> sendRiderequesttonearestdriver(
      String gender, BuildContext context) async {
    for (Nearbyavailabledrivers driver
        in Geofireassistant.nearbyavailabledriverslist) {
      final doc = await FirebaseFirestore.instance
          .collection('drivers')
          .doc(driver.key)
          .get();
      String drivergender =
          Provider.of<Userdataprovider>(context, listen: false)
              .userData['Gender'];
      if (drivergender == gender) {
        String token = doc['token'];
        initfcm(token);
      }
    }
  }
}
