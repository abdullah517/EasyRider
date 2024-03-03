import 'package:flutter/material.dart';
import 'package:ridemate/routing/routing.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/customappbar.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/basicinfo.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/cnic.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/listtile.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/selfiewithid.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/vehicleinfo.dart';

class Transport extends StatelessWidget {
  final String title;
  const Transport({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(context,
          title: title, backgroundColor: Appcolors.primaryColor),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
            ),
            child: Container(
              height: 370,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0), // Adjust padding as needed
                      child: CustomListTile(
                        title: 'Basic Info',
                        icon: null,
                        onTap: () {
                          navigateToScreen(
                              context, const basicinfo(title: 'Basic Info'));
                        },
                      ),
                    ),
                    const Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0), // Adjust padding as needed
                      child: CustomListTile(
                        title: 'CNIC',
                        icon: null,
                        onTap: () {
                          navigateToScreen(
                            context,
                            const CNIC(title: 'CNIC'),
                          );
                        },
                      ),
                    ),
                    const Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0), // Adjust padding as needed
                      child: CustomListTile(
                        title: 'Selfie with ID',
                        icon: null,
                        onTap: () {
                          navigateToScreen(
                            context,
                            const Selfiewithid(title: 'Selfie with ID'),
                          );
                        },
                      ),
                    ),
                    const Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0), // Adjust padding as needed
                      child: CustomListTile(
                        title: 'Vehicle Info',
                        icon: null,
                        onTap: () {
                          navigateToScreen(
                            context,
                            const vehicleinfo(title: 'Vehicle Info'),
                          );
                        },
                      ),
                    ),
                    const Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
