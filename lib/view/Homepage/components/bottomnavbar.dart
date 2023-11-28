import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Homeprovider/homeprovider.dart';
import 'package:ridemate/utils/appcolors.dart';

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Homeprovider>(
      builder: (context, homeprovider, child) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: homeprovider.currentpage,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 20.sp,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_outline,
                  size: 20.sp,
                ),
                label: 'Favourite',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/wallet.png',
                  width: 20.w,
                  height: 20.h,
                ),
                label: 'Wallet',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/offer.png',
                  width: 20.w,
                  height: 20.h,
                  color: homeprovider.currentpage == 3
                      ? Appcolors.primaryColor
                      : Appcolors.contentPrimary,
                ),
                label: 'Offer',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 20.sp,
                ),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              homeprovider.changecurrentpage(index);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Appcolors.primaryColor,
            unselectedItemColor: Appcolors.contentPrimary,
            showUnselectedLabels: true,
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: Appcolors.contentPrimary,
            ),
            selectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: Appcolors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
