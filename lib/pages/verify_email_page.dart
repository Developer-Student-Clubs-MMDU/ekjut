// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekjut/api/user_details.dart';
import 'package:ekjut/pages/homepage.dart';
import 'package:ekjut/wigets/button.dart';
import 'package:ekjut/wigets/red_button.dart';
import 'package:ekjut/wigets/userlocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  String currentUserUid = "";
  bool isEmailVerfied = false;
  bool canResendEmail = false;
  Timer? timer;
  // for entering location of user into list
  List<double> list = [];

  // calling get location function for taking user's location as input
  Future<List<double>> getlocation() async {
    UserLocation location = UserLocation();
    list = await location.getUserLocation();
    print(list);
    return list;
  }

  @override
  void initState() {
    super.initState();
    getlocation();
    isEmailVerfied = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerfied) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
    // else {
    //   addUser();
    // }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (err) {
      Fluttertoast.showToast(
          msg: "$err",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerfied = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerfied) {
      // addUser();
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return isEmailVerfied
        ? const HomeScreen()
        : Scaffold(
            body: Center(
                child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("check your email for verfication link"),
              ElevatedButton(
                child: const Text("Send Vefirfication email"),
                onPressed: canResendEmail ? sendVerificationEmail : null,
                // width: _width * 0.7,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  // try {
                  //   print("hello");
                  // } catch (err) {
                  //   print(err);
                  // }
                },
                // width: _width * 0.7,
              ),
            ],
          )));
  }

  // Future addUser() async {
  //   // print(context.watch<UserDetails>().uid);
  //   final userId = context.watch<UserDetails>().uid;
  //   print("inside add user function");
  //   print(userId);
  //   DocumentReference users = FirebaseFirestore.instance.doc('users/' + userId);

  //   return await users
  //       .set({'uid': currentUserUid, 'company': "company", 'age': "age"})
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
}
