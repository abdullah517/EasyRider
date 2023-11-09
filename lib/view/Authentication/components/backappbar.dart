import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/widgets/customtext.dart';

class Backappbar extends StatelessWidget {
  const Backappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24.sp,
            )),
        CustomText(
          title: 'Back',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Appcolors.contentSecondary,
        )
      ],
    );
  }
}
