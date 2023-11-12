// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/backappbar.dart';
import 'package:ridemate/view/Authentication/components/custompinput.dart';
import 'package:ridemate/view/Authentication/components/customrichtext.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';

class Forgetverifyotp extends StatelessWidget {
  const Forgetverifyotp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalspace(height: 10.h),
                const Backappbar(),
                addVerticalspace(height: 15),
                CustomText(
                  title: 'Forgot Password',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Appcolors.contentPrimary,
                ),
                addVerticalspace(height: 12),
                CustomText(
                  title: 'Code has been send to ***** ***70',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Appcolors.neutralgrey,
                ),
                addVerticalspace(height: 40),
                Custompinput(),
                addVerticalspace(height: 20),
                Customrichtext(
                  texts: const [
                    'Didn’t receive code?',
                    ' Resend again',
                  ],
                ),
                addVerticalspace(
                    height: MediaQuery.of(context).viewInsets.bottom == 0.0
                        ? 270.h
                        : 330.h - MediaQuery.of(context).viewInsets.bottom),
                Custombutton(
                  text: 'Verify ',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  borderRadius: 8,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
