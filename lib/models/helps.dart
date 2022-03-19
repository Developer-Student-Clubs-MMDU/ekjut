import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Helps {
  final String desc;
  final String uid;
  // bool inProgress = false;
  final List<dynamic> services;
  final Timestamp time;
  final GeoPoint location;

  Helps(
      {required this.desc,
      required this.uid,
      // required this.inProgress,
      required this.services,
      required this.time,
      required this.location});

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "uid": uid,
        // "inProgress": inProgress,
        "services": services,
        "time": time,
        "location": location
      };
  static Helps fromJson(Map<String, dynamic> json) => Helps(
      uid: json["uid"],
      desc: json["desc"],
      // inProgress: json["inProgress"],
      location: json["location"],
      time: json["time"],
      services: json["services"]);
}

Widget buildHelp(Helps help) =>
//  Text(help.uid);
    Padding(
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
            child:
                Align(alignment: Alignment.centerLeft, child: Text(help.desc)),
          ),
        ],
      ),
    );

//  ListTile(
//       leading: CircleAvatar(child: Text(help.uid)),
//       title: Text(help.uid),
//       subtitle: Text(help.uid),
//     );

Stream<List<Helps>>? readHelps() => FirebaseFirestore.instance
    .collection("helps")
    .where("services", arrayContainsAny: ["Service 2"])
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Helps.fromJson(doc.data())).toList());
