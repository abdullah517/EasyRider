import 'package:flutter/material.dart';

import '../../phoneotp/phoneotp.dart';

class Verifyotpprovider extends ChangeNotifier {
  bool loading = false;
  final _phoneotp = PhoneOtp();
  String errormessage = '';

  Future<void> verifyOTP(String phoneNo, String otp) async {
    loading = true;
    notifyListeners();
    String response = await _phoneotp.verifyOTP(phoneNo, otp);
    if (response == 'Success') {
      loading = false;
      errormessage = '';
      notifyListeners();
    } else {
      loading = false;
      errormessage = response;
      notifyListeners();
    }
  }
}
