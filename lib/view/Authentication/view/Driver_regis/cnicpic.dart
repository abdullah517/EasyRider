import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/utils/appimages.dart';

import '../../../../../Providers/completeprofileprovider.dart';

// ignore: camel_case_types
class cnicpic extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const cnicpic({Key? key});

  @override
  Widget build(BuildContext context) {
    final myprovider =
        Provider.of<Completeprofileprovider>(context, listen: false);
    return Center(
      child: Stack(
        children: [
          Consumer<Completeprofileprovider>(
            builder: (context, pic, child) => ClipRRect(
              borderRadius:
                  BorderRadius.circular(10.0), // Adjust the radius as needed
              child: Container(
                color: Appcolors.neutralgrey200,
                width: 200.w,
                height: 100.h,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: myprovider.uploadImage,
              child: Image.asset(
                AppImages.camerapic,
                height: 26.h,
                width: 26.w,
              ),
            ),
          )
        ],
      ),
    );
  }
}
