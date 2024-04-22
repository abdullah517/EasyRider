// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';

import '../../../widgets/custombutton.dart';

void showridebottomsheet(BuildContext context, String rideid) {
  showModalBottomSheet(
    isDismissible: false,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Rides(rideid: rideid),
      ),
    ),
  );
}

class Rides extends StatefulWidget {
  final String rideid;
  const Rides({super.key, required this.rideid});

  @override
  State<Rides> createState() => _RidesState();
}

class _RidesState extends State<Rides> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
            top: -12,
            child: Container(
              width: 60,
              height: 7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('RideRequest')
                .doc(widget.rideid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data!.data()!['driversid'].length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    List driversid = snapshot.data!.data()!['driversid'];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 16.0),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/personimage.jpg'),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16.0,
                            left: 105.0,
                            child: CustomText(
                              title: 'Suzuki Alto',
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
                            top: 64.0,
                            left: 105.0,
                            child: CustomText(
                              title: 'Wasim ${driversid[index]}',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
                            top: 16.0,
                            right: 10.0,
                            child: CustomText(
                              title: 'PKR 1,447',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Positioned(
                            top: 50.0,
                            right: 10.0,
                            child: CustomText(
                              title: '5 min.',
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
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
                                  ontap: () {},
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
                  },
                  separatorBuilder: (context, index) =>
                      addVerticalspace(height: 7),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}