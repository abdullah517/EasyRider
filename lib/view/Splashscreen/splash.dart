// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Verifyotpprovider/verifyotpprovider.dart';
import 'package:ridemate/routing/routing.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/utils/appimages.dart';
import 'package:ridemate/view/Authentication/view/Completeprofile/completeprofile.dart';
import 'package:ridemate/view/Homepage/home.dart';
import 'package:ridemate/view/Onboarding/onboarding.dart';
import 'package:ridemate/widgets/customcontainer.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/Completeprofileprovider/completeprofileprovider.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  Future<void> checkloginstatus(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool islogin = prefs.getBool('isLogin') ?? false;
    final String phoneuserid = prefs.getString('phoneuserid') ?? '';

    if (FirebaseAuth.instance.currentUser != null) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('googleusers');
      DocumentSnapshot document =
          await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (document['Gender'] != null && document['Username'] != null) {
        navigateandremove(context, const Homepage());
      } else {
        final cnicprovider =
            Provider.of<Completeprofileprovider>(context, listen: false);
        navigateToScreen(
          context,
          Completeprofile(
            onPressed1: () {
              Navigator.pop(context);
              cnicprovider.scanCnic(ImageSource.camera, context, users,
                  FirebaseAuth.instance.currentUser!.uid);
            },
            onPressed2: () {
              Navigator.pop(context);
              cnicprovider.scanCnic(ImageSource.gallery, context, users,
                  FirebaseAuth.instance.currentUser!.uid);
            },
          ),
        );
      }
    } else if (islogin) {
      final verifyprovider =
          Provider.of<Verifyotpprovider>(context, listen: false);
      CollectionReference users =
          FirebaseFirestore.instance.collection('mobileusers');
      String asciiPhoneNumber = phoneuserid.codeUnits.join('-');
      DocumentSnapshot document = await users.doc(asciiPhoneNumber).get();
      if (document['Gender'] != null && document['Username'] != null) {
        navigateandremove(context, const Homepage());
      } else {
        navigateToScreen(
          context,
          Completeprofile(
            onPressed1: () {
              verifyprovider.profilefunction(
                  context, phoneuserid, ImageSource.camera);
            },
            onPressed2: () {
              verifyprovider.profilefunction(
                  context, phoneuserid, ImageSource.gallery);
            },
          ),
        );
      }
    } else {
      navigateandremove(context, Onboarding());
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), (() => checkloginstatus(context)));
    return Scaffold(
      backgroundColor: Appcolors.splashbgColor,
      body: Center(
        child: Column(
          children: [
            addVerticalspace(height: 240),
            Customcontainer(
              height: 120,
              width: 125.76,
              borderRadius: 34,
              child: Image.asset(
                AppImages.splashlogo1,
                width: 71.w,
                height: 68.h,
              ),
            ),
            addVerticalspace(height: 15),
            const CustomText(
              title: 'Easy Rider',
              fontSize: 45,
              fontWeight: FontWeight.w800,
            ),
            addVerticalspace(height: 15),
            Image.asset(
              AppImages.splashlogo2,
              height: 100.h,
              width: 100.w,
              color: Appcolors.scaffoldbgcolor,
            ),
          ],
        ),
      ),
    );
  }
}
