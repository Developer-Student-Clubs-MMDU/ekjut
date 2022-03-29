import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekjut/pages/homepage.dart';
import 'package:ekjut/wigets/ripple_animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WatingHelp extends StatefulWidget {
  const WatingHelp({Key? key}) : super(key: key);

  @override
  State<WatingHelp> createState() => _WatingHelpState();
}

class _WatingHelpState extends State<WatingHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF36306D).withOpacity(1),
                const Color(0xFF1C173D)
              ]),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
                decoration: BoxDecoration(
                    color: const Color(0xFF599091).withOpacity(0.4),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100.0),
                    )),
                child: RippleAnimation(
                  color: const Color(0xFF599091).withOpacity(1),
                  minRadius: 70,
                  repeat: true,
                  child: const Icon(Icons.search_rounded,
                      color: Colors.white, size: 24.0),
                  ripplesCount: 6,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(
                        color: Colors.white,
                        // fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                    child: AnimatedTextKit(
                      pause: const Duration(milliseconds: 400),
                      repeatForever: true,
                      animatedTexts: [
                        WavyAnimatedText("Searching for Help..."),
                      ],
                      isRepeatingAnimation: true,
                    ),                  ),
                  const SizedBox(height: 100.0),
                  ElevatedButton(
                    onPressed: () {
                      final user = FirebaseAuth.instance.currentUser;
                      print('================================================= $user');
                      print(user?.uid);
                      print('======================================================');
                      FirebaseFirestore.instance
                          .collection('helps')
                          .doc(user?.uid)
                          .delete();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: const Text("Cancel Help"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
