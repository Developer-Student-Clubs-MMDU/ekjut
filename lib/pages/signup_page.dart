// ignore_for_file: avoid_print

import 'package:ekjut/wigets/button.dart';
import 'package:ekjut/wigets/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _emailcontroller = TextEditingController();
    final _passwordcontroller = TextEditingController();
    // final _locationdcontroller = TextEditingController();
    final _confirmpasswordcontroller = TextEditingController();
    Future signup() async {
      print("button pressed");

      if (_passwordcontroller.text.trim() ==
          _confirmpasswordcontroller.text.trim()) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailcontroller.text.trim(),
              password: _confirmpasswordcontroller.text.trim());
        } catch (e) {
          Fluttertoast.showToast(
              msg: "Password should be at least 6 characters",
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
    );
  }
}
