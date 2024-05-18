// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/homeprovider.dart';
import 'package:ridemate/Providers/mapprovider.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';

import '../../../services/pushnotificationservice.dart';
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

late StreamSubscription subs;

class _RidesState extends State<Rides> {
  List<Map<String, dynamic>> driverdata = [];

  Future<void> sendAcceptmessage(
      String driverid, BuildContext context, int fare) async {
    final doc = await FirebaseFirestore.instance
        .collection('drivers')
        .doc(driverid)
        .get();
    String token = doc['token'];
    PushNotificationService service = PushNotificationService();
    await service.sendNotification(
      token,
      title: "Get Ready",
      bodytxt: "Pick your new Ride",
      rideid: widget.rideid,
    );
    FirebaseFirestore.instance
        .collection('RideRequest')
        .doc(widget.rideid)
        .update({'Status': 'Accepted', 'ridefare': fare});
    final myprovider = Provider.of<Mapprovider>(context, listen: false);
    final homeprovider = Provider.of<Homeprovider>(context, listen: false);
    homeprovider.setemptyaddress();
    Navigator.pop(context);
    savebookdriverinfo(driverid, doc);
    myprovider.resetmarkers();
    await myprovider.bookeddriverstatus(widget.rideid, context);
    final usertoken = await service.getToken();
    await service
        .sendNotification(
          usertoken!,
          title: "Ride booked",
          bodytxt: "Your driver is coming in few mins",
        )
        .then((value) => deleteunuseddata());
    startlistener();
    homeprovider.showbooksheet();
  }

  Future<void> datafromfirestore(String driverid) async {
    final firestore = FirebaseFirestore.instance.collection('drivers');
    final docref = await firestore.doc(driverid).get();
    final map = docref.data() as Map<String, dynamic>;
    driverdata.add(map);
  }

  void deleteunuseddata() {
    final docref =
        FirebaseFirestore.instance.collection('RideRequest').doc(widget.rideid);
    docref.update(({
      'driversdata': FieldValue.delete(),
      'requestdrivers': FieldValue.delete(),
    }));
  }

  void savebookdriverinfo(String driverid, var doc) {
    final docref =
        FirebaseFirestore.instance.collection('RideRequest').doc(widget.rideid);

    docref.set(
        ({
          'driverid': driverid,
          'drivername': doc['Name'],
          'carname': doc['Transportname'],
        }),
        SetOptions(merge: true));
  }

  void startlistener() {
    String checkstatus = 'checkarrive';
    subs = FirebaseFirestore.instance
        .collection('RideRequest')
        .doc(widget.rideid)
        .snapshots()
        .listen((event) async {
      if (event.exists && event.data() != null) {
        var data = event.data()!;
        var status = data['Status'];
        if (checkstatus == 'checkarrive') {
          if (status == 'Arrived') {
            checkstatus = 'checkdest';
            PushNotificationService service = PushNotificationService();
            final token = await service.getToken();
            await service.sendNotification(token!,
                title: 'Your driver has arrived',
                bodytxt: 'Remember to check details');
            subs.cancel();
          }
        }
      }
    });
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
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('RideRequest')
                .doc(widget.rideid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<dynamic> driversdata =
                    snapshot.data!.data()!['driversdata'];

                return FutureBuilder(
                  future: Future.wait(driversdata
                      .map((driver) => datafromfirestore(driver['driverid']))),
                  builder: (context, futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.done) {
                      return ListView.separated(
                        itemCount: driverdata.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final durationtxt =
                              driversdata[index]['driverdir']['duration'];
                          final distancetxt =
                              driversdata[index]['driverdir']['distance'];
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
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 10.0),
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
                                    title: driverdata[index]['Transportname'],
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Positioned(
                                  top: 64.0,
                                  left: 105.0,
                                  child: CustomText(
                                    title: driverdata[index]['Name'],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Positioned(
                                  top: 16.0,
                                  right: 10.0,
                                  child: CustomText(
                                    title:
                                        '${driversdata[index]['driverfare']}PKR',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                Positioned(
                                  top: 50.0,
                                  right: 10.0,
                                  child: CustomText(
                                    title: '$durationtxt',
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Positioned(
                                  top: 80.0,
                                  right: 10.0,
                                  child: CustomText(
                                    title: '$distancetxt',
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Custombutton(
                                        text: 'Accept',
                                        ontap: () async {
                                          await sendAcceptmessage(
                                            driversdata[index]['driverid'],
                                            context,
                                            int.parse(driversdata[index]
                                                    ['driverfare']
                                                .toString()),
                                          );
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
                        },
                        separatorBuilder: (context, index) =>
                            addVerticalspace(height: 7),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
