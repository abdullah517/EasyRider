// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/bookingprovider.dart';
import 'package:ridemate/services/pushnotificationservice.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/Methods/drivermethods.dart';
import 'package:ridemate/view/Authentication/view/Driver/bottomnav.dart';
import 'package:ridemate/view/Authentication/view/Driver/driverdrawer.dart';
import 'package:ridemate/view/Authentication/view/Driver/toggle_button.dart';
import 'package:ridemate/widgets/customtext.dart';
import '../../../../Providers/userdataprovider.dart';

class Driverscreen extends StatefulWidget {
  const Driverscreen({Key? key}) : super(key: key);

  @override
  State<Driverscreen> createState() => _DriverscreenState();
}

class _DriverscreenState extends State<Driverscreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void showsnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: CustomText(title: text),
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<void> savetoken(Map driver, bool isOnline) async {
    if (isOnline) {
      final service = PushNotificationService();
      String? token = await service.getToken();
      final firestore = FirebaseFirestore.instance.collection('drivers');
      if (driver.containsKey('token')) {
        firestore
            .doc(Provider.of<Userdataprovider>(context, listen: false).userId)
            .update({'token': '$token'});
      } else {
        firestore
            .doc(Provider.of<Userdataprovider>(context, listen: false).userId)
            .set({'token': '$token'}, SetOptions(merge: true));
      }
      service.refreshtoken(firestore, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Appcolors.primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 150, top: 15, bottom: 00),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('drivers')
                    .doc(Provider.of<Userdataprovider>(context, listen: false)
                        .userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return ToggleSwitch(
                        onChanged: (value) {
                          showsnackbar('Complete the Registration Process');
                        },
                        initialValue: false);
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!.data() as Map;
                    bool isOnline = false;
                    if (data.containsKey('Status')) {
                      return ToggleSwitch(
                        initialValue: isOnline,
                        onChanged: (value) {
                          if (data['Status'] == 'Approved') {
                            setState(() {
                              isOnline = value;
                            });
                            changedriverstatus(context, value);
                            savetoken(data, value);
                          } else {
                            showsnackbar(
                                'Your application status is in Review');
                          }
                        },
                      );
                    } else {
                      return ToggleSwitch(
                          onChanged: (value) {
                            showsnackbar('Complete the Registration Process');
                          },
                          initialValue: false);
                    }
                  } else {
                    return ToggleSwitch(
                        onChanged: (value) {
                          showsnackbar('Complete the Registration Process');
                        },
                        initialValue: false);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const driverdrawer(),
      body: Consumer<Bookingprovider>(
        builder: (context, value, child) => ListView.separated(
          itemBuilder: (context, index) => value.ridelist[index],
          separatorBuilder: (context, index) => const SizedBox(height: 6),
          itemCount: value.ridelist.length,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
