import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../phoneotp/phoneotp.dart';

class Verifyotpprovider extends ChangeNotifier {
  bool loading = false;
  final _phoneotp = PhoneOtp();
  String errormessage = '';
  bool enabled = false;
  bool haveuser = false;

  Future<void> verifyOTP(String phoneNo, String otp) async {
    loading = true;
    notifyListeners();
    String response = await _phoneotp.verifyOTP(phoneNo, otp);
    if (response == 'Success') {
      addUserToFirestore(phoneNo);
      loading = false;
      errormessage = '';
      notifyListeners();
    } else {
      loading = false;
      errormessage = response;
      notifyListeners();
    }
  }

  Future<void> addUserToFirestore(String mobileNo) async {
    CollectionReference mobileUsers =
        FirebaseFirestore.instance.collection('mobileusers');

    String asciiPhoneNumber = mobileNo.codeUnits.join('-');

    bool documentExists =
        await mobileUsers.doc(asciiPhoneNumber).get().then((doc) => doc.exists);

    if (!documentExists) {
      await mobileUsers.doc(asciiPhoneNumber).set({
        'phoneNumber': mobileNo,
      });
    } else {
      haveuser = true;
    }
  }

  void changebuttonstate(bool btnstate) {
    enabled = btnstate;
    notifyListeners();
  }
}
