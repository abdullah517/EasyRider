import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/routing/routing.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/utils/appimages.dart';
import 'package:ridemate/view/Homepage/home.dart';
import 'package:ridemate/view/Onboarding/onboarding.dart';
import 'package:ridemate/widgets/customcontainer.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  Future<void> checkloginstatus(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool islogin = prefs.getBool('isLogin') ?? false;
    final String phoneuserid = prefs.getString('phoneuserid') ?? '';
    if (islogin) {
      if (FirebaseAuth.instance.currentUser != null) {
        // ignore: use_build_context_synchronously
        navigateandremove(context, const Homepage());
      } else {
        // ignore: use_build_context_synchronously
        navigateandremove(context, Homepage(phoneno: phoneuserid));
      }
    } else {
      // ignore: use_build_context_synchronously
      navigateToScreen(context, Onboarding());
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
