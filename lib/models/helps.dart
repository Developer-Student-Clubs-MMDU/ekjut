import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekjut/pages/get_location.dart';
import 'package:ekjut/pages/map.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:georange/georange.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:geoflutterfire/geoflutterfire.dart';

class Helps {
  final String desc;
  final String uid;
  bool inProgress = false;
  final List<dynamic> services;
  final Timestamp time;
  final GeoPoint location;
  final String locHash;
  String helperUid = "";
  Timestamp helperStartedHelp = Timestamp.now();
  int estimatedTime = 0;

  Helps(
      {required this.locHash,
      required this.desc,
      required this.uid,
      required this.inProgress,
      required this.services,
      required this.time,
      required this.location});

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "uid": uid,
        "inProgress": inProgress,
        "services": services,
        "time": time,
        "location": location,
        "locHash": locHash,
      };
  static Helps fromJson(Map<String, dynamic> json) => Helps(
        uid: json["uid"],
        desc: json["desc"],
        inProgress: json["inProgress"],
        location: json["location"],
        time: json["time"],
        services: json["services"],
        locHash: json["locHash"],
      );
}

Widget buildHelp(Helps help, BuildContext context) =>
//  Text(help.uid);
    InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MapsPage(help: help
                // personLocation: latLng.LatLng(
                //     help.location.latitude, help.location.longitude),
                // index: index,
                ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ExpansionTile(
          backgroundColor: Color.fromRGBO(26, 41, 128, 100),
          collapsedBackgroundColor: const Color.fromRGBO(26, 41, 128, 100),
          title: Text(
            help.uid,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(help.uid),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 8.0),
              child: Align(
                  alignment: Alignment.centerLeft, child: Text(help.desc)),
            ),
          ],
        ),
      ),
    );
Widget buildPointer(Helps help, BuildContext context) =>
//  Text(help.uid);
    InkWell(
      onTap: () {
        //  Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => MapsPage(

        //               personLocation: latLng.LatLng(help.location.latitude, help.location.longitude), index: index,
        //                   ),
        //         ),
        //       );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          backgroundColor: Colors.green,
          collapsedBackgroundColor: Colors.yellow,
          title: Text(
            help.uid,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(help.uid),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(help.desc),
              ),
            ),
          ],
        ),
      ),
    );

//  ListTile(
//       leading: CircleAvatar(child: Text(help.uid)),
//       title: Text(help.uid),
//       subtitle: Text(help.uid),
//     );

GeoRange georange = GeoRange();

Future<Position> position =
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

Stream<List<Helps>>? readHelps(showService, range, limit) =>
    FirebaseFirestore.instance
        .collection("helps")
        .where("services", arrayContainsAny: [showService])
        // .where("locHash", isGreaterThanOrEqualTo: range.lower)
        // .where("locHash", isLessThanOrEqualTo: range.upper)
        .limit(10)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Helps.fromJson(doc.data())).toList());
