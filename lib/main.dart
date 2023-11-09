import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Loginprovider/loginprovider.dart';
import 'package:ridemate/Providers/Onboardingprovider/onboardingprovider.dart';
import 'package:ridemate/view/Splashscreen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => Onboardingprovider(),
            ),
            ChangeNotifierProvider(
              create: (context) => LoginProvider(),
            ),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'RideMate',
            theme: ThemeData(
              // This is the theme of your application.
              useMaterial3: false,
            ),
            home: const Splashscreen(),
          ),
        );
      },
    );
  }
}
