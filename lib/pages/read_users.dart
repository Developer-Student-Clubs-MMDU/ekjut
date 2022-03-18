import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ekjut/models/user.dart';
import 'package:flutter/material.dart';

// Stream<List<User>> readUser() =>
//     FirebaseFirestore.instance.collection("users").snapshots().map((snapshot) =>
//         snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
Stream<List<User>> readUser() =>
    FirebaseFirestore.instance.collection("users").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

Widget buildUser(Try user) => ListTile(
      leading: CircleAvatar(child: Text(user.name)),
      title: Text(user.name),
      subtitle: Text(user.name),
    );

Future createUser(User user) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc();

  final json = user.toJson();
  await docUser.set(json);
}

Stream<List<Try>>? readdata() => FirebaseFirestore.instance
    .collection("mydata")
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Try.fromJson(doc.data())).toList());
