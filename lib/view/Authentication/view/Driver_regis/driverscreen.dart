import 'package:flutter/material.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/bottomnav.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/driverdrawer.dart';
//import 'package:ridemate/utils/appcolors.dart';
//import 'package:ridemate/view/Authentication/components/customappbar.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/toggle_button.dart';

class Driverscreen extends StatefulWidget {
  final String title;
  const Driverscreen({Key? key, required this.title}) : super(key: key);

  @override
  State<Driverscreen> createState() => _DriverscreenState();
}

class _DriverscreenState extends State<Driverscreen> {
  bool _isOnline = true;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          title: const Text(""),
          backgroundColor: Appcolors.primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 150, top: 15, bottom: 00),
              child: ToggleSwitch(
                initialValue: _isOnline,
                onChanged: (value) {
                  setState(() {
                    _isOnline = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const driverdrawer(),
      body: Container(
          // Your body content here
          ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
