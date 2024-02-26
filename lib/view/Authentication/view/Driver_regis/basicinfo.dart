import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/customappbar.dart';
import 'package:ridemate/view/Authentication/view/Completeprofile/components/profilepic.dart';
import 'package:ridemate/widgets/custombutton.dart';

// ignore: camel_case_types
class basicinfo extends StatelessWidget {
  final String title;
  const basicinfo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(context,
          title: title, backgroundColor: Appcolors.primaryColor),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: Container(
            height: 350,
            width: 450,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                  ),
                  child: Text(
                    "Photo",
                    style: TextStyle(
                      // Making text bold
                      color: Colors.black, // Changing text color
                      fontSize: 18, // Changing text size
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                      ),
                    ),
                    const Profilepic(),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Custombutton(
                          text: 'Add a Photo',
                          height: 40,
                          width: 200,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          borderRadius: 8,
                          ontap: () {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Custombutton(
              text: 'Done',
              height: 60,
              width: 300,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              borderRadius: 8,
              ontap: () {}),
        ),
      ]),
    );
  }
}
