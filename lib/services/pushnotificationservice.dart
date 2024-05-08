// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/bookingprovider.dart';
import 'package:ridemate/models/ridedetails.dart';

import '../Providers/userdataprovider.dart';

Future<String> getAccessToken() async {
  // Load the service account credentials from the JSON key file
  final jsonString = await rootBundle.loadString('assets/service-account.json');
  final serviceAccountCredentials =
      ServiceAccountCredentials.fromJson(jsonString);

  var scopes = ['https://www.googleapis.com/auth/cloud-platform'];

  // Create an authorized client
  final client =
      await clientViaServiceAccount(serviceAccountCredentials, scopes);

  // Obtain the access token
  final accessToken = client.credentials.accessToken;
  print('Access token is ${accessToken.data}');
  return accessToken.data;
}

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification?.title == "New Ride Request") {
        retrieveRideRequestDetail(message, context);
        displayNotification(message);
      } else {
        displayNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });
  }

  Future<void> retrieveRideRequestDetail(
      RemoteMessage message, BuildContext context) async {
    final ridedetail = await FirebaseFirestore.instance
        .collection('RideRequest')
        .doc(message.data['ride_request_id'])
        .get();
    RideDetails rideDetails = RideDetails(
      rideid: message.data['ride_request_id'],
      pickupaddress: ridedetail['pickup_address'],
      destinationaddress: ridedetail['destination_address'],
      pickup: LatLng(
        double.parse(ridedetail['pickup']['latitude'].toString()),
        double.parse(ridedetail['pickup']['longitude'].toString()),
      ),
      dropoff: LatLng(
        double.parse(ridedetail['dropoff']['latitude'].toString()),
        double.parse(ridedetail['dropoff']['longitude'].toString()),
      ),
      ridername: ridedetail['rider_name'],
    );
    Provider.of<Bookingprovider>(context, listen: false)
        .updateridelist(rideDetails);
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('token is $token');
    return token;
  }

  void refreshtoken(CollectionReference firestore, BuildContext context) {
    _firebaseMessaging.onTokenRefresh.listen((event) {
      firestore
          .doc(Provider.of<Userdataprovider>(context, listen: false).userId)
          .update({'token': event});
    });
  }

  Future<void> displayNotification(RemoteMessage message) async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        platformChannelSpecifics,
        payload: message.data.toString(),
      );
    } catch (e) {
      print('Error displaying notification: $e');
    }
  }

  Future<void> sendNotification(
    String token, {
    String rideid = '',
    required String title,
    required String bodytxt,
  }) async {
    String oauthid = await getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $oauthid',
    };

    var body = jsonEncode({
      "message": {
        "token": token,
        "notification": {"title": title, "body": bodytxt},
        "data": rideid != ''
            ? {"status": "processed", 'ride_request_id': rideid}
            : {"status": "processed"}
      }
    });
    try {
      var response = await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/ridemate-7d7f7/messages:send'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('_________message sent_______________');
      } else {
        print('_________message not sent_______________');
      }
    } catch (e) {
      print('______error is ${e.toString()}_______');
    }
  }
}
