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
  // onPressed: canResendEmail ? sendVerificationEmail : null,
  //   FirebaseAuth.instance.signOut();

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return isEmailVerfied
        ? const HomeScreen()
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF36306D).withOpacity(1),
                      const Color(0xFF1C173D)
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(
                        Icons.mark_email_unread_outlined,
                        color: Colors.white.withOpacity(0.6),
                        size: 120,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      // color: Colors.white.withOpacity(0.3),
                      color: Color(0xFF1C173D),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Check Verfication Email",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          // fontFamily: "Roboto",
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "You must have received an email verification link on your email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          // fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                      child: const Text('Send Verification Mail'),
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                    ),
                  ),
                  OutlinedButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 2.0, color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
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
