import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/userdataprovider.dart';
import 'package:ridemate/routing/routing.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Hometransport/components/hometransportcomp1.dart';
import 'package:ridemate/view/Hometransport/components/search.dart';
import 'package:ridemate/widgets/customcontainer.dart';

class Hometransport extends StatefulWidget {
  final void Function()? ontap;
  final String? phoneno;
  const Hometransport({super.key, this.ontap, this.phoneno});

  @override
  State<Hometransport> createState() => _HometransportState();
}

class _HometransportState extends State<Hometransport> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(33.6941, 72.9734), zoom: 14.4746);

  final FocusNode _focusNode = FocusNode();
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
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _kGooglePlex,
          zoomControlsEnabled: false,
          onMapCreated: (mapcontroller) {
            _controller.complete(mapcontroller);
            setposition();
          },
          markers: Set<Marker>.of(markers),
        ),
        Positioned(
          left: 15,
          right: 15,
          top: 37,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: widget.ontap,
                  child: const Hometransportcomp1(icon: Icons.menu)),
              const Hometransportcomp1(icon: Icons.notifications),
            ],
          ),
        ),
        Positioned(
            bottom: 120,
            left: 15,
            right: 15,
            child: Customcontainer(
              padding: const EdgeInsets.all(14),
              width: 364.w,
              height: 90,
              borderRadius: 8,
              border: Border.all(color: Appcolors.primaryColor),
              color: const Color(0xffFFFBE7),
              child: TextField(
                onTap: () {
                  _focusNode.unfocus();
                  navigateToScreen(context, const Search());
                },
                readOnly: true,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                    hintText: 'Where would you go?',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.favorite),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.primaryColor))),
              ),
            ))
      ],
    );
  }
}
