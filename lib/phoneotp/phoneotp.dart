import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_credential.dart';

class PhoneOtp {
  String hashvalue = '';
  String otpCode = '';
  String baseurl =
      'http://otp-api-env.eba-pvpxpp43.ap-south-1.elasticbeanstalk.com/auth';

  static final PhoneOtp _phoneOtp = PhoneOtp._internal();
  factory PhoneOtp() {
    return _phoneOtp;
  }
  PhoneOtp._internal();

  Future<String> generateotp(String phoneNo) async {
    String url = '$baseurl/send-otp';
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: {'phone': phoneNo},
      );
      Map<String, dynamic> responsedata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<String> data = responsedata['data']!.split('#');
        hashvalue = data[0];
        otpCode = data[1];
        return "${responsedata['message']}";
      } else {
        return "${responsedata['message']}";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> sendOTP(String phoneNo) async {
    String url = 'https://rest.moceanapi.com/rest/2/sms';
    String message = await generateotp(phoneNo);

    if (message == 'Success') {
      Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json'
      };

      Map<String, String> body = {
        'mocean-api-key': apiKey,
        'mocean-api-secret': apiSecret,
        'mocean-from': 'RideMate',
        'mocean-to': phoneNo,
        'mocean-text':
            'Your otp for phone verification is $otpCode. It will expire in 5 minutes.',
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: body,
        );
        Map<String, dynamic> responsedata = jsonDecode(response.body);
        if (responsedata['messages'][0]['status'] == 0) {
          return message;
        } else {
          return responsedata['messages'][0]['err_msg'];
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      return message;
    }
  }

  Future<String> verifyOTP(String phoneNo, String otp) async {
    String url = '$baseurl/verify-otp';
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };
    Map<String, String> body = {
      'phone': phoneNo,
      'otp': otp,
      'hash': hashvalue
    };
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      Map<String, dynamic> responsedata = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responsedata['message'];
      } else {
        return responsedata['message'];
      }
    } catch (e) {
      return e.toString();
    }
  }
}
