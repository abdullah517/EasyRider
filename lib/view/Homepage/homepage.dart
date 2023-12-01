import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Homeprovider/homeprovider.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Dialogueboxes/locationdialogue.dart';
import 'package:ridemate/view/Homepage/components/bottomnavbar.dart';
import 'package:ridemate/view/Homepage/components/homecomp1.dart';
import 'package:ridemate/view/Homepage/components/sidemenubar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await locationdialogue(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _scaffoldState,
      drawer: const Sidemenubar(),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: sourceLocation,
              zoom: 13.5,
            ),
            zoomControlsEnabled: false,
            cloudMapId: 'c28ce90f6f3fda60',
            markers: {
              const Marker(
                  markerId: MarkerId('source'), position: sourceLocation),
              const Marker(
                  markerId: MarkerId('destination'), position: destination),
            },
            onMapCreated: (mapcontroller) =>
                _controller.complete(mapcontroller),
          ),
          Positioned(
            left: 15,
            right: 15,
            top: 37,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => _scaffoldState.currentState!.openDrawer(),
                    child: const Homecomp1(icon: Icons.menu)),
                const Homecomp1(icon: Icons.notifications),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const Bottomnavbar(),
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
