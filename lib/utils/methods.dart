// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../routing/routing.dart';
import '../view/Authentication/view/Driver_regis/driverscreen.dart';
import '../view/Dialogueboxes/congratdialogue.dart';

Future<bool> checkAllFieldsExist(String userId) async {
  final driversCollection = FirebaseFirestore.instance.collection('drivers');

  final DocumentSnapshot docSnapshot =
      await driversCollection.doc(userId).get();

  if (docSnapshot.exists) {
    final data = docSnapshot.data() as Map<String, dynamic>;
    return data.containsKey('Driver Licence Frontside') &&
        data.containsKey('Driver Licence Backside') &&
        data.containsKey('Cnicno') &&
        data.containsKey('CNIC Frontside') &&
        data.containsKey('CNIC Backside') &&
        data.containsKey('Selfie with ID') &&
        data.containsKey('Basic Info') &&
        data.containsKey('Photo of Vehicle') &&
        data.containsKey('Vehicle Registration Frontside') &&
        data.containsKey('Vehicle Registration Backside') &&
        data.containsKey('Transportname');
  } else {
    return false;
  }
}

Future<void> checkit(String userId, BuildContext context) async {
  if (await checkAllFieldsExist(userId)) {
    congratdialogue(context);
    FirebaseFirestore.instance
        .collection('drivers')
        .doc(userId)
        .set({'Status': 'InReview'}, SetOptions(merge: true));
    navigateandremove(context, const Driverscreen());
  } else {
    Navigator.pop(context);
  }
}
