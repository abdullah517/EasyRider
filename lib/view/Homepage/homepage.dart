import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/homeprovider.dart';
import 'package:ridemate/Providers/mapprovider.dart';
import 'package:ridemate/Providers/useraddressprovider.dart';
import 'package:ridemate/Providers/userdataprovider.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Homepage/components/homecomp1.dart';
import 'package:ridemate/view/Homepage/components/search.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/customtext.dart';

class Homepage extends StatefulWidget {
  final String? phoneno;
  const Homepage({super.key, this.phoneno});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Completer<GoogleMapController> _controller = Completer();
  final _scaffoldState = GlobalKey<ScaffoldState>();

  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(33.6941, 72.9734), zoom: 14.4746);

  final Set<Marker> markers = {};

  Future<Position> getuserCurrentLocation() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Userdataprovider>(context, listen: false)
        .loaduserdata(widget.phoneno);
  }

  void setposition() {
    getuserCurrentLocation().then((value) async {
      Provider.of<Homeprovider>(context, listen: false)
          .convertlatlngtoaddress(value);
      Provider.of<Pickupaddress>(context, listen: false)
          .updateaddress(value.latitude, value.longitude);
      markers.add(
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'userlocation'),
        ),
      );
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14.4746);
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Stack(
        children: [
          Consumer<Mapprovider>(
            builder: (context, value, child) => GoogleMap(
              initialCameraPosition: _kGooglePlex,
              zoomControlsEnabled: false,
              onMapCreated: (mapcontroller) {
                _controller.complete(mapcontroller);
                setposition();
              },
              markers: Set<Marker>.of(markers),
              polylines: value.polylineset,
            ),
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
          ),
          Consumer<Homeprovider>(
            builder: (context, value, child) => value.address == ''
                ? const SizedBox()
                : Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 250,
                      padding: const EdgeInsets.only(
                          bottom: 20, top: 15, left: 15, right: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            title: 'Where to?',
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: Appcolors.primaryColor,
                          ),
                          ListTile(
                            leading: const Icon(Icons.location_on),
                            title: CustomText(
                              title: value.address,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Appcolors.contentDisbaled,
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.location_on),
                            title: CustomText(
                              title: value.destination,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Appcolors.contentDisbaled,
                            ),
                            onTap: () => showbottomsheet(context),
                          ),
                          const Spacer(),
                          Custombutton(
                            text: 'Confirm destination',
                            ontap: () {},
                            fontSize: 16,
                            borderRadius: 8,
                          )
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
