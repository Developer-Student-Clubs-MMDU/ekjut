import 'package:flutter/material.dart';
import 'package:ekjut/api/changing_location.dart';
import 'package:ekjut/pages/get_location.dart';
import 'package:ekjut/pages/get_timings.dart';
import 'package:ekjut/wigets/button.dart';
import 'package:ekjut/wigets/input.dart';
import 'package:ekjut/wigets/userlocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';

class MakeProfile extends StatefulWidget {
  const MakeProfile({Key? key}) : super(key: key);

  @override
  _MakeProfileState createState() => _MakeProfileState();
}

class _MakeProfileState extends State<MakeProfile> {
  // for entering location of user into list
  List<double> list = [];

  // calling get location function for taking user's location as input
  void getlocation() async {
    UserLocation location = UserLocation();
    list = await location.getUserLocation();
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
    final _namedcontroller = TextEditingController();
    // final _locationdcontroller = TextEditingController();
    final _servivecontroller = TextEditingController();
    return Container(
      width: _width,
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(height: 100),
          InputWidget(
            icon: FontAwesomeIcons.userAlt,
            label: "Name",
            controller: _namedcontroller,
          ),
          const SizedBox(height: 30),
          InputWidget(
            icon: FontAwesomeIcons.inbox,
            label: "Email",
            controller: _emailcontroller,
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              if (list.isEmpty) {
                Fluttertoast.showToast(
                    msg: "We are enable to detect your location");
                return;
                // print('empty');
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GetMyLocation(
                    list: list,
                  ),
                ),
              );
            },
            child: context.watch<ChangeLocation>().foundLocation
                ? Column(
                    children: [
                      Container(
                        height: 60,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: const Color(0xFF1C173D),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.map,
                                size: 18,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(width: 14),
                              Text(
                                context.watch<ChangeLocation>().source,
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 60,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: const Color(0xFF1C173D),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.map,
                                size: 18,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(width: 14),
                              Text(
                                context.watch<ChangeLocation>().destination,
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: const Color(0xFF1C173D),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.map,
                            size: 18,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 14),
                          Text(
                            "Location",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 30),
          InputWidget(
            icon: FontAwesomeIcons.handsHelping,
            label: "Services",
            controller: _servivecontroller,
          ),
          const SizedBox(height: 40),
          ButtonWidget(
            width: _width * 0.5,
            label: "Sign up",
            onPress: () {
              Future signUp() async {
                try {
                  print("siging up...");
                  //    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
                } catch (e) {
                  print(e);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
