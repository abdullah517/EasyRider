import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/utils/appimages.dart';
import 'package:ridemate/view/Authentication/view/Login/login.dart';
import 'package:ridemate/view/Authentication/view/Signup/signup.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                addVerticalspace(height: 60),
                SvgPicture.asset(
                  AppImages.welcomeimg,
                  height: 276.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                addVerticalspace(height: 29),
                CustomText(
                  title: 'Welcome',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Appcolors.contentPrimary,
                ),
                CustomText(
                  title: 'Have a better sharing experience',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Appcolors.neutralgrey,
                ),
                addVerticalspace(height: 100),
                Custombutton(
                  text: 'Create an account',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  borderRadius: 8,
                  ontap: () => Get.to(() => const Signup()),
                ),
                addVerticalspace(height: 20),
                Custombutton(
                  text: 'Log In',
                  fontColor: Appcolors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  bordercolor: Appcolors.primaryColor,
                  borderRadius: 8,
                  haveborder: true,
                  ontap: () => Get.to(() => const Login()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
