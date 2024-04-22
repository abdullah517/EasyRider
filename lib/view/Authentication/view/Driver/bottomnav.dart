import 'package:flutter/material.dart';
import 'package:ridemate/utils/appcolors.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Set the type to fixed
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Ride Requests',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: 'My Income',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border_outlined),
          label: 'Rating',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment),
          label: 'Pay',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Appcolors.primaryColor,
      onTap: onItemTapped,
    );
  }
}
