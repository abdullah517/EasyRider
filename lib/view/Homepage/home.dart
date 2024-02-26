import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/view/Hometransport/hometransport.dart';
import '../../Providers/Homeprovider/homeprovider.dart';
import '../../utils/appcolors.dart';
import '../Hometransport/components/sidemenubar.dart';

class Homepage extends StatefulWidget {
  final String? phoneno;
  const Homepage({super.key, this.phoneno});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List pages = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];
  final _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Homeprovider>(
        builder: (context, index, child) => index.currentpage == 0
            ? Hometransport(
                ontap: _scaffoldState.currentState!.openDrawer,
                phoneno: widget.phoneno,
              )
            : pages[index.currentpage - 1],
      ),
      extendBody: true,
      key: _scaffoldState,
      drawer: const Sidemenubar(),
      bottomNavigationBar: Consumer<Homeprovider>(
        builder: (context, homeprovider, child) => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 58,
        width: 63,
        child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () => Provider.of<Homeprovider>(context, listen: false)
              .changecurrentpage(2),
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Appcolors.primaryColor,
          child: Image.asset('assets/wallet.png'),
        ),
      ),
    );
  }
}
