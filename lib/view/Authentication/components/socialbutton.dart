import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/utils/appimages.dart';
import 'package:ridemate/widgets/customtext.dart';

class Socialbutton extends StatelessWidget {
  final String text;
  const Socialbutton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h,
      width: 362.w,
      child: ElevatedButton.icon(
        icon: Image.asset(
          AppImages.googlelogo,
          height: 24.h,
          width: 24.w,
        ),
        label: CustomText(
          title: text,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Appcolors.primaryColor,
        ),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          side: const BorderSide(color: Appcolors.primaryColor, width: 1),
        ),
      ),
    );
  }
}
