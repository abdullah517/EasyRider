import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridemate/routing/routing.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Hometransport/components/hometransportcomp1.dart';
import 'package:ridemate/view/Hometransport/components/search.dart';
import 'package:ridemate/widgets/customcontainer.dart';

class Hometransport extends StatelessWidget {
  final void Function()? ontap;
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  final FocusNode _focusNode = FocusNode();

  Hometransport({super.key, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: sourceLocation,
            zoom: 13.5,
          ),
          zoomControlsEnabled: false,
          markers: {
            const Marker(
                markerId: MarkerId('source'), position: sourceLocation),
            const Marker(
                markerId: MarkerId('destination'), position: destination),
          },
          onMapCreated: (mapcontroller) => _controller.complete(mapcontroller),
        ),
        Positioned(
          left: 15,
          right: 15,
          top: 37,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: ontap,
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
                  navigateToScreen(context, Search());
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
