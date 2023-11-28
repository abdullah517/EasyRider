import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/view/Authentication/view/forgetverifyotp/forgetverifyotp.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/spacing.dart';

import '../../../../routing/routing.dart';
import '../../../../utils/appcolors.dart';
import '../../../../widgets/customtext.dart';
import '../../components/authtextform.dart';
import '../../components/backappbar.dart';

class Sendverification extends StatelessWidget {
  const Sendverification({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalspace(height: 10.h),
                  const Backappbar(),
                  addVerticalspace(height: 15),
                  CustomText(
                    title: 'Verification email or phone number ',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Appcolors.contentPrimary,
                  ),
                  addVerticalspace(height: 20),
                  Authtextform(
                    hinttext: 'Email or Phone Number',
                  ),
                  addVerticalspace(height: 350.h),
                  Custombutton(
                      text: 'Send OTP ',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      borderRadius: 8,
                      ontap: () =>
                          navigateToScreen(context, const Forgetverifyotp())),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
