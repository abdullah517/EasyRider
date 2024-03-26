import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ridemate/utils/api_credential.dart';

// import 'dart:async';

// import 'package:googleapis_auth/auth_io.dart';

// import 'package:flutter/services.dart' show rootBundle;

// Future<void> getAccessToken() async {
//   // Load the service account credentials from the JSON key file
//   final jsonString = await rootBundle.loadString('assets/service-account.json');
//   final serviceAccountCredentials =
//       ServiceAccountCredentials.fromJson(jsonString);

//   var scopes = ['https://www.googleapis.com/auth/cloud-platform'];

//   // Create an authorized client
//   final client =
//       await clientViaServiceAccount(serviceAccountCredentials, scopes);

//   // Obtain the access token
//   final accessToken = client.credentials.accessToken;

//   // Print the access token value
//   print('Access token: ${accessToken.data}');
// }

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      displayNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });
  }

  Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      return token;
    } catch (e) {
      return 'Error getting token: $e';
    }
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

  Future<void> sendNotification() async {
    await init();
    String? token = await getToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $oauthid',
    };

    var body = jsonEncode({
      "message": {
        "token": "$token",
        "notification": {
          "title": "New Ride Request",
          "body": "You have a new ride request."
        },
        "data": {"status": "processed"}
      }
    });

    var response = await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/ridemate-7d7f7/messages:send'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print(await response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}
