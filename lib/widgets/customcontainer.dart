import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Customcontainer extends StatelessWidget {
  double borderRadius;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  BoxBorder? border;
  Color color;
  Widget? child;
  double height;
  double width;
  Customcontainer({
    super.key,
    this.borderRadius = 0.0,
    this.color = const Color(0xffffffff),
    this.child,
    this.height = 0.0,
    this.width = 0.0,
    this.padding,
    this.margin,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        color: color,
        border: border,
      ),
      child: child,
    );
  }
}
