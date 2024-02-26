import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Userdataprovider extends ChangeNotifier {
  Map<String, dynamic> userData = {};
  Future<void> loaduserdata(String? phoneno) async {
    if (FirebaseAuth.instance.currentUser == null) {
      CollectionReference mobileUsers =
          FirebaseFirestore.instance.collection('mobileusers');
      String userid = phoneno!.codeUnits.join('-');
      DocumentSnapshot snapshot = await mobileUsers.doc(userid).get();
      userData = snapshot.data() as Map<String, dynamic>;
    } else {
      final userid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference googleUsers =
          FirebaseFirestore.instance.collection('googleusers');
      DocumentSnapshot snapshot = await googleUsers.doc(userid).get();
      userData = snapshot.data() as Map<String, dynamic>;
    }
  }
}
