import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/utils/appimages.dart';
import 'package:ridemate/view/Onboarding/onboarding.dart';
import 'package:ridemate/widgets/customcontainer.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        (() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Onboarding(),
            ))));
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
            CustomText(
              title: 'Easy Rider',
              fontSize: 45,
              fontWeight: FontWeight.w800,
            ),
            addVerticalspace(height: 15),
            Image.asset(
              AppImages.splashlogo2,
              height: 100.h,
              width: 100.w,
            ),
          ],
        ),
      ),
    );
  }
}
