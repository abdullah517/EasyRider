import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customcontainer extends StatelessWidget {
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final Color color;
  final Widget? child;
  final double height;
  final double width;
  final String imagepath;
  const Customcontainer({
    super.key,
    this.borderRadius = 0.0,
    this.color = const Color(0xffffffff),
    this.child,
    this.height = 0.0,
    this.width = 0.0,
    this.padding,
    this.margin,
    this.border,
    this.imagepath = '',
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
          image: imagepath != ''
              ? DecorationImage(image: AssetImage(imagepath), fit: BoxFit.cover)
              : null),
      child: child,
    );
  }
}
