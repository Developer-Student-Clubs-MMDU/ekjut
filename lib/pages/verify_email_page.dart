import 'dart:async';

import 'package:ekjut/pages/homepage.dart';
import 'package:ekjut/wigets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerfied = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerfied = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerfied) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerfied = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerfied) {
      timer?.cancel();
    }
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
              ButtonWidget(
                label: "Send Vefirfication email",
                onPress: () {
                  sendVerificationEmail();
                },
                width: _width * 0.7,
              )
            ],
          )));
  }
}
