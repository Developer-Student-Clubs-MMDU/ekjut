// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekjut/api/user_details.dart';
import 'package:ekjut/wigets/button.dart';
import 'package:ekjut/wigets/input.dart';
import 'package:ekjut/wigets/userlocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late Map<String, dynamic> fetchedUser = {};

  List<double> list = [];
  late GeoPoint userloc;
  Future getlocation() async {
    UserLocation location = UserLocation();
    list = await location.getUserLocation();
    print("xxxxxxxxxxxxxxxxxxxx$list");
    userloc = GeoPoint(list[0], list[1]);

    return userloc;
  }

  @override
  void initState() {
    super.initState();
    getlocation();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _emailcontroller = TextEditingController();
    final _passwordcontroller = TextEditingController();
    final _confirmpasswordcontroller = TextEditingController();
    Future signup() async {
      print("button pressed");
      print(_emailcontroller.text.trim());
      if (_passwordcontroller.text.trim() ==
          _confirmpasswordcontroller.text.trim()) {
        try {
          final currentUser = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emailcontroller.text.trim(),
                  password: _confirmpasswordcontroller.text.trim())
              .then((value) {
            print("i am in");
            final userId = value.user!.uid;
            FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .set({
                  'uid': userId,
                  'location': userloc,
                  'email': _emailcontroller.text.trim()
                })
                .then((value) => print("User Added"))
                .catchError((error) => print("Failed to add user: $error"));
          });
          // print("oooooooo ${currentUser.user?.email}");
          // context.read<UserDetails?>()!.update(currentUser);
        } catch (e) {
          Fluttertoast.showToast(
              msg: e.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          print(e);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Confirm Password is incorrect",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    return Container(
      width: _width,
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            InputWidget(
              icon: FontAwesomeIcons.userAlt,
              label: "Email",
              controller: _emailcontroller,
            ),
            const SizedBox(height: 30),
            InputWidget(
              icon: FontAwesomeIcons.inbox,
              label: "Password",
              controller: _passwordcontroller,
            ),
            const SizedBox(height: 30),
            InputWidget(
              icon: FontAwesomeIcons.inbox,
              label: "Confirm Password",
              controller: _confirmpasswordcontroller,
            ),
            const SizedBox(height: 40),
            ButtonWidget(
              width: _width * 0.5,
              label: "Verify Email",
              onPress: () {
                try {
                  print("siging up...");
                  signup();
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
