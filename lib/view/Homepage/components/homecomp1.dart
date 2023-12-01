import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/widgets/customcontainer.dart';

class Homecomp1 extends StatelessWidget {
  final IconData? icon;
  const Homecomp1({super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return Customcontainer(
      width: 32.w,
      height: 28.h,
      borderRadius: 8,
      padding: const EdgeInsets.all(4),
      color: Appcolors.primary100,
      child: Icon(
        icon,
        size: 24.sp,
        color: Appcolors.contentTertiary,
      ),
    );
  }
}
