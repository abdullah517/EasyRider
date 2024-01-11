import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ridemate/routing/routing.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/goingtoworkas.dart';
import 'package:ridemate/view/Hometransport/components/menubarcomp.dart';
import 'package:ridemate/view/Welcomescreen/welcomescreen.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidemenubar extends StatelessWidget {
  final String? phoneno;
  const Sidemenubar({super.key, this.phoneno});

  Future<Map<String, dynamic>> loaduserdata(String? phoneno) async {
    if (FirebaseAuth.instance.currentUser == null) {
      CollectionReference mobileUsers =
          FirebaseFirestore.instance.collection('mobileusers');
      String userid = phoneno!.codeUnits.join('-');
      DocumentSnapshot snapshot = await mobileUsers.doc(userid).get();
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      return userData;
    } else {
      final userid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference googleUsers =
          FirebaseFirestore.instance.collection('googleusers');
      DocumentSnapshot snapshot = await googleUsers.doc(userid).get();
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      return userData;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogin', false);
      if (FirebaseAuth.instance.currentUser != null) {
        await GoogleSignIn().disconnect();
      }
      // ignore: use_build_context_synchronously
      navigateandremove(context, const Welcomescreen());
    }

    return SafeArea(
      child: Drawer(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80),
                  bottomRight: Radius.circular(80))),
          backgroundColor: Appcolors.scaffoldbgcolor,
          child: FutureBuilder(
            future: loaduserdata(phoneno),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    UserAccountsDrawerHeader(
                        accountName: CustomText(
                          title: snapshot.data!['Username'],
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Appcolors.contentSecondary,
                        ),
                        accountEmail: CustomText(
                          title: phoneno != null
                              ? snapshot.data!['phoneNumber']
                              : snapshot.data!['Email'],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Appcolors.contentSecondary,
                        ),
                        decoration: const BoxDecoration(
                            color: Appcolors.scaffoldbgcolor),
                        currentAccountPicture: CircleAvatar(
                          radius: 40,
                          backgroundImage: snapshot.data!['Profileimage'] == ''
                              ? const AssetImage('assets/personimage.png')
                                  as ImageProvider
                              : NetworkImage(snapshot.data!['Profileimage']),
                        )),
                    const Menubarcomp(
                        text: 'Edit Profile', icon: Icons.person_outline),
                    const Divider(color: Appcolors.neutralgrey, height: 1),
                    const Menubarcomp(text: 'History', icon: Icons.history),
                    const Divider(color: Appcolors.neutralgrey, height: 1),
                    const Menubarcomp(text: 'Complain', icon: Icons.info),
                    const Divider(color: Appcolors.neutralgrey, height: 1),
                    const Menubarcomp(
                        text: 'About Us', icon: Icons.info_outline),
                    const Divider(color: Appcolors.neutralgrey, height: 1),
                    const Menubarcomp(text: 'Settings', icon: Icons.settings),
                    const Divider(color: Appcolors.neutralgrey, height: 1),
                    const Menubarcomp(
                        text: 'Help and Support',
                        icon: Icons.help_outline_outlined),
                    const Divider(color: Appcolors.neutralgrey, height: 1),
                    Menubarcomp(
                        text: 'Logout',
                        icon: Icons.logout_outlined,
                        onTap: logout),
                    const Divider(color: Appcolors.neutralgrey, height: 1),
                    addVerticalspace(height: 20),
                    Custombutton(
                      buttoncolor: Appcolors.primaryColor,
                      ontap: () {
                        navigateToScreen(context, const GoingtoWorkAs());
                      },
                      text: 'Driver Mode',
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
