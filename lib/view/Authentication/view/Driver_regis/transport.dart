import 'package:flutter/material.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/customappbar.dart';
import 'package:ridemate/view/Authentication/view/Driver_regis/listtile.dart';

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
                        onTap: () {},
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
                        title: 'Basic Info',
                        icon: null,
                        onTap: () {},
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
                        title: 'Basic Info',
                        icon: null,
                        onTap: () {},
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
                        title: 'Basic Info',
                        icon: null,
                        onTap: () {},
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
