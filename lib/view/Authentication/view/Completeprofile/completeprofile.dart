import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/authtextform.dart';
import 'package:ridemate/view/Authentication/components/backappbar.dart';
import 'package:ridemate/view/Dialogueboxes/congratdialogue.dart';
import 'package:ridemate/widgets/customcontainer.dart';
import 'package:ridemate/widgets/spacing.dart';

import '../../../../widgets/custombutton.dart';

class Completeprofile extends StatelessWidget {
  const Completeprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Appcolors.scaffoldbgcolor,
      body: Form(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalspace(height: 24.h),
              const Backappbar(title: 'Profile'),
              addVerticalspace(height: 30.h),
              Center(
                child: Stack(
                  children: [
                    Customcontainer(
                      width: 121.w,
                      height: 100.h,
                      color: Appcolors.neutralgrey200,
                      borderRadius: 60,
                    ),
                    Positioned(
                        bottom: -3,
                        right: 4,
                        child: Customcontainer(
                          height: 23.h,
                          width: 31.w,
                          color: Appcolors.primaryColor,
                          borderRadius: 20,
                          child: Icon(
                            Icons.camera_alt,
                            color: const Color(0xffffffff),
                            size: 17.sp,
                          ),
                        )),
                  ],
                ),
              ),
              addVerticalspace(height: 30),
              Authtextform(hinttext: 'Full Name'),
              addVerticalspace(height: 20),
              Authtextform(hinttext: 'Cnic no'),
              addVerticalspace(height: 20),
              Authtextform(hinttext: 'Date of birth'),
              addVerticalspace(height: 20),
              Authtextform(hinttext: 'Gender'),
              addVerticalspace(height: 20),
              Authtextform(hinttext: 'City'),
              addVerticalspace(height: 30),
              Custombutton(
                text: 'Save',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                borderRadius: 8,
                ontap: () => congratdialogue(context),
              ),
              addVerticalspace(height: 10),
            ],
          ),
        ),
      )),
    ));
  }
}
