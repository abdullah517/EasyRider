import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Googleloginprovider extends ChangeNotifier {
  bool loading = false;

  Future<void> signInWithGoogle() async {
    loading = true;
    notifyListeners();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((userCredential) {
      loading = false;
      notifyListeners();
      print(userCredential);
    });
  }
}
