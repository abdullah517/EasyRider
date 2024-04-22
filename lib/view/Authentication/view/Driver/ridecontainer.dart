import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/userdataprovider.dart';
import 'package:ridemate/models/ridedetails.dart';
import 'package:ridemate/widgets/customtext.dart';

import '../../../../widgets/custombutton.dart';

class Ridecontainer extends StatelessWidget {
  final RideDetails rideDetails;
  const Ridecontainer({super.key, required this.rideDetails});

  void savedriverid(BuildContext context, String id) async {
    final docRef = FirebaseFirestore.instance.collection('RideRequest').doc(id);
    final driverid =
        Provider.of<Userdataprovider>(context, listen: false).userId;
    List newData = [driverid];
    await docRef.update({
      'driversid': FieldValue.arrayUnion(newData),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: MediaQuery.of(context).size.width,
      height: 200,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 16.0),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/personimage.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 100.0,
            left: 45.0,
            child: CustomText(
              title: rideDetails.ridername,
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 16.0,
            left: 105.0,
            child: CustomText(
              title: rideDetails.pickupaddress,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 50.0,
            left: 105.0,
            child: CustomText(
              title: rideDetails.destinationaddress,
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          const Positioned(
            top: 16.0,
            right: 10.0,
            child: CustomText(
              title: 'PKR 1,447',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const Positioned(
            top: 50.0,
            right: 10.0,
            child: CustomText(
              title: '5 min.',
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          const Positioned(
            top: 80.0,
            right: 10.0,
            child: CustomText(
              title: '463 m',
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Custombutton(
                  text: 'Accept',
                  ontap: () {
                    savedriverid(context, rideDetails.rideid);
                  },
                  fontSize: 16,
                  borderRadius: 8,
                  height: 50,
                  width: 130,
                  fontWeight: FontWeight.bold,
                ),
                Custombutton(
                  text: 'Decline',
                  ontap: () {},
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  borderRadius: 8,
                  height: 50,
                  width: 130,
                  fontColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
