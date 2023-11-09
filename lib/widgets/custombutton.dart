import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/widgets/customtext.dart';

// ignore: must_be_immutable
class Custombutton extends StatelessWidget {
  double height;
  double width;
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color fontColor;
  Color buttoncolor;
  Color bordercolor;
  double borderRadius;
  Function? ontap;
  bool haveborder;
  IconData icon;

  Custombutton({
    super.key,
    this.height = 54,
    this.width = 362,
    this.text = '',
    this.fontSize = 15,
    this.borderRadius = 20,
    this.buttoncolor = Appcolors.primaryColor,
    this.fontColor = Colors.white,
    this.bordercolor = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.ontap,
    this.haveborder = false,
    this.icon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        onPressed: ontap != null ? () => ontap!() : () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: haveborder ? Colors.white : buttoncolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          side: haveborder ? BorderSide(color: bordercolor, width: 1) : null,
        ),
        child: text == ''
            ? Icon(
                icon,
                size: 25.sp,
                color: Appcolors.contentTertiary,
              )
            : CustomText(
                title: text,
                fontSize: fontSize,
                color: fontColor,
                fontWeight: fontWeight,
              ),
      ),
    );
  }
}
