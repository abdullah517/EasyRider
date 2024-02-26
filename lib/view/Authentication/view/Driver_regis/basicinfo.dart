import 'package:flutter/material.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/customappbar.dart';

// ignore: camel_case_types
class basicinfo extends StatelessWidget {
  final String title;
  const basicinfo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(context,
          title: title, backgroundColor: Appcolors.primaryColor),
    );
  }
}
