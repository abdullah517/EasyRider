import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/routing/routing.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/widgets/customtext.dart';

class Backappbar extends StatelessWidget {
  final String title;
  const Backappbar({super.key, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return title == ''
        ? Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () => goback(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20.sp,
                )),
          )
        : Row(
            children: [
              IconButton(
                  onPressed: () => goback(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20.sp,
                  )),
              Expanded(
                child: Center(
                  child: CustomText(
                    title: title,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Appcolors.contentPrimary,
                  ),
                ),
              ),
            ],
          );
  }
}
