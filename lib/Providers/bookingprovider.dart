import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/homeprovider.dart';
import 'package:ridemate/Providers/useraddressprovider.dart';
import 'package:ridemate/Providers/userdataprovider.dart';

class Bookingprovider extends ChangeNotifier {
  void saveRideRequest(BuildContext context) {
    final firestore = FirebaseFirestore.instance.collection('Ride Requests');
    final pickup = Provider.of<Pickupaddress>(context, listen: false);
    final destination = Provider.of<Destinationaddress>(context, listen: false);
    final address = Provider.of<Homeprovider>(context, listen: false);
    final user = Provider.of<Userdataprovider>(context, listen: false);
    firestore.doc(user.userId).set({
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
}
