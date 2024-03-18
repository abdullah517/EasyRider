import 'package:flutter/material.dart';
import 'package:ridemate/routing/routing.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/goingtoworkas.dart';
//import 'package:ridemate/view/Authentication/view/Driver_regis/goingtoworkas.dart';
import 'package:ridemate/view/Homepage/components/menubarcomp.dart';
import 'package:ridemate/view/Homepage/homepage.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/spacing.dart';

// ignore: camel_case_types
class driverdrawer extends StatelessWidget {
  const driverdrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(80),
                bottomRight: Radius.circular(80))),
        backgroundColor: Appcolors.scaffoldbgcolor,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            Menubarcomp(
              text: 'Registration',
              icon: Icons.person_outline,
              onTap: () {
                navigateToScreen(context, const GoingtoWorkAs());
              },
            ),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(text: 'Edit Profile', icon: Icons.person_outline),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(text: 'History', icon: Icons.history),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(text: 'Settings', icon: Icons.settings),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(
                text: 'Help and Support', icon: Icons.help_outline_outlined),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            addVerticalspace(height: 20),
            Custombutton(
              buttoncolor: Appcolors.primaryColor,
              ontap: () {
                navigateToScreen(context, const Homepage());
              },
              text: 'Passenger Mode',
            ),
          ],
        ),
      ),
    );
  }
}
