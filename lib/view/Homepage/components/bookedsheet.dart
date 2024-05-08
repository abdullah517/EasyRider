import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/utils/appcolors.dart';

import '../../../routing/routing.dart';
import '../../../widgets/custombutton.dart';
import '../../../widgets/customtext.dart';
import '../../messagingscreen/messagingscreen.dart';

void showbookedsheet(BuildContext context) {
  showModalBottomSheet(
    isDismissible: false,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150.w,
                  height: 5.h,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [],
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                )
              ],
            ),
            Container(
              height: 50.h,
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: const CustomText(
                      title: 'Your driver is coming in 03:35',
                      fontSize: 15,
                      color: Appcolors.neutralgrey700,
                      fontWeight: FontWeight.bold,
                      //style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Appcolors.neutralgrey200,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: Appcolors.primaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                title: 'Abdullah',
                                fontSize: 15,
                                color: Appcolors.contentSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.location_pin, size: 16),
                                    SizedBox(width: 4),
                                    CustomText(
                                      title: '800m\n(5mins away)',
                                      fontSize: 7,
                                      color: Appcolors.neutralgrey200,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Appcolors.primaryColor,
                                        size: 16),
                                    SizedBox(width: 4),
                                    CustomText(
                                      title: '4.9\n(531 reviews)',
                                      fontSize: 7,
                                      color: Appcolors.neutralgrey200,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Appcolors.primaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80.h,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: 'Payment method',
                          fontSize: 14,
                          color: Appcolors.neutralgrey700,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          title: '\$220.00',
                          fontSize: 22,
                          color: Appcolors.contentPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80.h,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 320.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Appcolors.primaryColor,
                            ),
                            color: Appcolors.primary100,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Appcolors.primaryColor,
                                    ),
                                    color: Appcolors.primaryColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title: '**** **** **** 7458',
                                      fontSize: 14,
                                      color: Appcolors.neutralgrey700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      title: 'Expires: 12/26',
                                      fontSize: 14,
                                      color: Appcolors.neutralgrey200,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80.h,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 320.w,
                          height: 70.h,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.02,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Appcolors.primaryColor,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Appcolors.primaryColor,
                                        child: Icon(
                                          Icons.call,
                                          color: Appcolors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.02,
                                    ),
                                    child: GestureDetector(
                                      onTap: () => navigateToScreen(
                                          context,
                                          const ChatScreen(
                                              title: 'Message Screen')),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Appcolors.primaryColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.message,
                                            color: Appcolors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.02,
                                ),
                                child: Custombutton(
                                  text: 'Cancel Ride',
                                  height: 40.h,
                                  width: 130.w,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  borderRadius: 8,
                                  ontap: () {},
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 150.w,
              height: 5.h,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
