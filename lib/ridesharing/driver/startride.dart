import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ridemate/services/pushnotificationservice.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/customappbar.dart';
import 'dart:async';

class Startride extends StatefulWidget {
  final String rideid;
  const Startride({Key? key, required this.rideid}) : super(key: key);
  @override
  State<Startride> createState() => _StartrideState();
}

class _StartrideState extends State<Startride> {
  late Future<List<Map<String, dynamic>>> _rideDetailsFuture;
  Timer? _locationUpdateTimer;
  Position? _currentPosition;
  GeoPoint? _driverLocation; // To store driver's live location from Firestore

  @override
  void initState() {
    super.initState();
    _rideDetailsFuture = _fetchRideDetails();
    _startLocationUpdateTimer(); // Start the location update timer
    _listenToDriverLocation(); // Listen to driver's live location from Firestore
  }

  @override
  void dispose() {
    _locationUpdateTimer?.cancel();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _fetchRideDetails() async {
    List<Map<String, dynamic>> rideDetails = [];
    QuerySnapshot bookingSnapshot = await FirebaseFirestore.instance
        .collection('booking')
        .where('rideid', isEqualTo: widget.rideid)
        .get();
    for (var bookingDoc in bookingSnapshot.docs) {
      var bookingData = bookingDoc.data() as Map<String, dynamic>;
      String userId = bookingData['userid'];

      DocumentSnapshot userSnapshot = await _getPassengerData(userId);
      if (userSnapshot.exists) {
        var userData = userSnapshot.data() as Map<String, dynamic>;
        String contactInfo = userData['provider'] == 'google'
            ? userData['Email'] ?? 'No Email'
            : userData['phoneNumber'] ?? 'No Phone Number';

        rideDetails.add({
          'username': userData['Username'] ?? 'No Name',
          'contactInfo': contactInfo,
          'startLocation': bookingData['userstartlocation']['address'],
          'dropLocation': bookingData['userdroplocation']['address'],
          'rideFare': bookingData['ridefare'],
          'userId': userId,  // Add userId to send notifications later
        });
      }
    }
    return rideDetails;
  }

  Future<DocumentSnapshot> _getPassengerData(String userId) async {
    var googleUserSnapshot =
        await FirebaseFirestore.instance.collection('googleusers').doc(userId).get();

    var mobileUserSnapshot =
        await FirebaseFirestore.instance.collection('mobileusers').doc(userId).get();

    if (googleUserSnapshot.exists) {
      return googleUserSnapshot;
    } else if (mobileUserSnapshot.exists) {
      return mobileUserSnapshot;
    } else {
      return FirebaseFirestore.instance.collection('dummy').doc(userId).get();
    }
  }

  Future<void> _sendNotificationToUser(String userId, String startLocation) async {
    try {
      // Get the user's token from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users-token')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        String? userToken = userSnapshot['token'];
        if (userToken != null && userToken.isNotEmpty) {
          // Send the push notification to the user
          await PushNotificationService().sendNotification(
            userToken,
            title: 'Ride Started',
            bodytxt: 'Please track him from booking page!',
          );
        }
      }
    } catch (e) {
      print('Error notifying user: $e');
    }
  }

  void _startLocationUpdateTimer() {
    // Start the location update timer
    _locationUpdateTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      _updateDriverLocation();
    });
  }

  void _updateDriverLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
      // Update driver's location in Firestore as string values
      FirebaseFirestore.instance.collection('booking').doc(widget.rideid).update({
        'livelocation': '${position.latitude},${position.longitude}',
      });
      print("update location");
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _listenToDriverLocation() {
    // Listen to driver's live location from Firestore
    FirebaseFirestore.instance.collection('booking').doc(widget.rideid).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          _driverLocation = snapshot['livelocation'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(
        context,
        title: 'Start Ride',
        backgroundColor: Appcolors.primaryColor,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _rideDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No bookings available for this ride.'),
            );
          }

          return Column(
            children: [
              ElevatedButton(
                onPressed: _startRide,
                child: Text('Start Ride'),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Your location is being shared with the users.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              if (_currentPosition != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Current Location: Lat: ${_currentPosition!.latitude}, Lon: ${_currentPosition!.longitude}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              if (_driverLocation != null) // Display driver's live location from Firestore
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Live Location from Firestore: Lat: ${_driverLocation!.latitude}, Lon: ${_driverLocation!.longitude}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var booking = snapshot.data![index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      color: Appcolors.primaryColor,
                      elevation: 4,
                      child: ListTile(
                        leading: Icon(Icons.person, color: Colors.white),
                        title: Text(
                          booking['username'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                         
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              'Contact Info: ${booking['contactInfo']}',
                              style: const TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              'Start Location: ${booking['startLocation']}',
                              style: const TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              'Drop Location: ${booking['dropLocation']}',
                              style: const TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Ride Fare: ${booking['rideFare']}',
                              style: const TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _startRide() async {
    List<Map<String, dynamic>> rideDetails = await _rideDetailsFuture;
    for (var booking in rideDetails) {
      _sendNotificationToUser(booking['userId'], booking['startLocation']);
    }
  }
}
