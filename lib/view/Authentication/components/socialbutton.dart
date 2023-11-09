import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/widgets/customcontainer.dart';

// ignore: must_be_immutable
class Socialbutton extends StatelessWidget {
  String path;
  Socialbutton({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Customcontainer(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(left: 8),
          width: 48.w,
          height: 48.h,
          borderRadius: 8,
          border: Border.all(color: Appcolors.contentDisbaled, width: 1.5),
          child: Image.asset(
            path,
            height: 24.h,
            width: 24.w,
          )),
    );
  }
}
