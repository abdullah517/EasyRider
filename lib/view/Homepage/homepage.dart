import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/homeprovider.dart';
import 'package:ridemate/Providers/mapprovider.dart';
import 'package:ridemate/Providers/userdataprovider.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Homepage/components/homecomp1.dart';
import 'package:ridemate/view/Homepage/components/search.dart';
import 'package:ridemate/view/Homepage/components/sidemenubar.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:image/image.dart' as images;
import 'package:ridemate/widgets/spacing.dart';

class Homepage extends StatefulWidget {
  final String? phoneno;
  const Homepage({super.key, this.phoneno});

  @override
  State<Homepage> createState() => _HomepageState();
}

Future<Uint8List> makeReceiptImage() async {
  // Load avatar image
  ByteData imageData = await rootBundle.load('assets/personimage.jpg');
  var bytes = Uint8List.view(imageData.buffer);
  var avatarImage = images.decodeImage(bytes);

  // Load marker image
  imageData = await rootBundle.load('assets/ma.png');
  bytes = Uint8List.view(imageData.buffer);
  var markerImage = images.decodeImage(bytes);

  // Resize the marker image to the desired dimensions
  markerImage = images.copyResize(markerImage!, width: 96, height: 122);

  // Resize the avatar image to fit inside the marker image
  avatarImage = images.copyResize(avatarImage!,
      width: markerImage.width ~/ 1.1, height: markerImage.height ~/ 1.4);

  var radius = 40;
  int originX = avatarImage.width ~/ 2, originY = avatarImage.height ~/ 2;

  // Draw the avatar image cropped as a circle inside the marker image
  for (int y = -radius; y <= radius; y++) {
    for (int x = -radius; x <= radius; x++) {
      if (originX + x + 8 >= 0 &&
          originX + x < avatarImage.width &&
          originY + y + 10 >= 0 &&
          originY + y < avatarImage.height &&
          x * x + y * y <= radius * radius) {
        markerImage.setPixel(originX + x + 8, originY + y + 10,
            avatarImage.getPixelSafe(originX + x, originY + y));
      }
    }
  }

  return images.encodePng(markerImage);
}

class _HomepageState extends State<Homepage> {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(33.6941, 72.9734), zoom: 14.4746);

  @override
  void initState() {
    super.initState();
    Provider.of<Userdataprovider>(context, listen: false)
        .loaduserdata(widget.phoneno);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      drawer: const Sidemenubar(),
      body: Stack(
        children: [
          Consumer<Mapprovider>(
            builder: (context, value, child) => GoogleMap(
              initialCameraPosition: _kGooglePlex,
              zoomControlsEnabled: false,
              onMapCreated: (mapcontroller) {
                value.controller.complete(mapcontroller);
                value.newgooglemapcontroller = mapcontroller;
                value.setposition(context);
              },
              markers: Set<Marker>.of(value.markers),
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
                      height: 250.h,
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
                            color: Appcolors.contentTertiary,
                          ),
                          addVerticalspace(height: 10),
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
