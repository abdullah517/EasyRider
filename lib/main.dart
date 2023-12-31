import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Completeprofileprovider/completeprofileprovider.dart';
import 'package:ridemate/Providers/Homeprovider/homeprovider.dart';
import 'package:ridemate/Providers/Onboardingprovider/onboardingprovider.dart';
import 'package:ridemate/Providers/Joinviaphoneprovider/joinviaphoneprovider.dart';
import 'package:ridemate/Providers/Verifyotpprovider/verifyotpprovider.dart';
import 'package:ridemate/firebase_options.dart';
import 'package:ridemate/view/Splashscreen/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
              create: (context) => Homeprovider(),
            ),
            ChangeNotifierProvider(
              create: (context) => Joinviaphoneprovider(),
            ),
            ChangeNotifierProvider(
              create: (context) => Verifyotpprovider(),
            ),
            ChangeNotifierProvider(
              create: (context) => Completeprofileprovider(),
            ),
          ],
          child: MaterialApp(
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
