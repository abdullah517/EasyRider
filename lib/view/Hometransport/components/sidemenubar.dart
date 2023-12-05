import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Hometransport/components/menubarcomp.dart';
import 'package:ridemate/widgets/customcontainer.dart';
import 'package:ridemate/widgets/customtext.dart';

class Sidemenubar extends StatelessWidget {
  const Sidemenubar({super.key});

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
          children: [
            UserAccountsDrawerHeader(
              accountName: CustomText(
                title: 'Nate Samson',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Appcolors.contentSecondary,
              ),
              accountEmail: CustomText(
                title: 'nate@email.con',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Appcolors.contentSecondary,
              ),
              decoration: const BoxDecoration(color: Appcolors.scaffoldbgcolor),
              currentAccountPicture: Customcontainer(
                height: 70.h,
                width: 70.w,
                borderRadius: 70,
                border: Border.all(color: Appcolors.primaryColor, width: 1),
                imagepath: 'assets/pic.jpg',
              ),
            ),
            const Menubarcomp(text: 'Edit Profile', icon: Icons.person_outline),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(
                text: 'Address', icon: Icons.location_on_outlined),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(text: 'History', icon: Icons.history),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(text: 'Complain', icon: Icons.info),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(text: 'Referral', icon: Icons.groups_3_outlined),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(text: 'About Us', icon: Icons.info_outline),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(text: 'Settings', icon: Icons.settings),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(
                text: 'Help and Support', icon: Icons.help_outline_outlined),
            const Divider(color: Appcolors.neutralgrey, height: 1),
            const Menubarcomp(text: 'Logout', icon: Icons.logout_outlined),
          ],
        ),
      ),
    );
  }
}
