import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';

class Backappbar extends StatelessWidget {
  final String title;
  const Backappbar({super.key, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
            )),
        CustomText(
          title: 'Back',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Appcolors.contentSecondary,
        ),
        addHorizontalspace(width: 55.w),
        CustomText(
          title: title,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Appcolors.contentPrimary,
        ),
      ],
    );
  }
}
