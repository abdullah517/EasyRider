import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/view/Authentication/components/hinttextstyle.dart';

// ignore: must_be_immutable
class Authtextform extends StatelessWidget {
  String? hinttext;
  Widget? suffixIcon;
  bool visibility;
  Authtextform(
      {super.key, this.hinttext, this.suffixIcon, this.visibility = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 362.w,
      height: 60.h,
      child: TextFormField(
        obscureText: visibility,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: gethintstyle(),
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
