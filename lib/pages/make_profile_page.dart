import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekjut/wigets/multi_choice.dart';
import 'package:ekjut/wigets/red_button.dart';
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
  List<dynamic> selectedServicesList = [];
  late Map<String, dynamic> fetchedUser = {};

  void fetchUserFromFirestore() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser?.uid)
        .get()
        .then((value) {
      print("fetched ${value.data()}");
      setState(() {
        fetchedUser = value.data()!;
        selectedServicesList = fetchedUser["services"];
        print(
            "selectedServicesList selectedServicesList ${selectedServicesList}");
      });
    });
  }

  // calling get location function for taking user's location as input
  void getlocation() async {
    UserLocation location = UserLocation();
    list = await location.getUserLocation();
  }

  @override
  void initState() {
    super.initState();
    fetchUserFromFirestore();
    getlocation();
  }

  // selectedServicesList=fetchedUser["services"];
  static List<String> servicesList = [
    "Service 1",
    "Service 2",
    "Service 3",
    "Service 4",
    "Service 5",
    "Service 6",
    "Service 7"
  ];

  _buildChoiceList() {
    print("services ${fetchedUser["services"].runtimeType}");
    List<Widget> servicesChoices = [];
    for (var item in selectedServicesList) {
      servicesChoices.add(Container(
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item),
        ),
      ));
    }
    return servicesChoices;
  }

  void displayBottomCameraMenu(BuildContext context, servicesList) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return SizedBox(
            height: 280.0,
            child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF1C173D),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select services",
                            style: TextStyle(
                                color: Colors.grey[200],
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                wordSpacing: 1.0),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.clear,
                                color: Colors.grey[200],
                              )),
                        ],
                      ),
                      MultiSelectChip(
                        servicesList,
                        onSelectionChanged: (selectedList) {
                          setState(() {
                            selectedServicesList = selectedList;
                            // print(selectedMonthList);
                          });
                        },
                        maxSelection: 7,
                      ),
                      ButtonWidget(
                        label: "Add",
                        width: 150,
                        onPress: () {
                          setState(() {
                            print("------------------ ${selectedServicesList}");
                            Navigator.pop(context);
                          });
                        },
                      )
                    ],
                  ),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final _emailcontroller = TextEditingController();
    final _namedcontroller = TextEditingController(text: fetchedUser["name"]);
    // final _locationdcontroller = TextEditingController();
    final _servivecontroller = TextEditingController();
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF36306D).withOpacity(1),
                  const Color(0xFF1C173D)
                ]),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.home, color: Color(0xFF1C173D)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  readOnly: false,
                  controller: _namedcontroller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    hintText: fetchedUser["name"] ?? "Enter name",
                    hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                        fontSize: 12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1C173D),
                    prefixIcon: Icon(
                      FontAwesomeIcons.inbox,
                      size: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  readOnly: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    hintText: fetchedUser["email"],
                    hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                        fontSize: 12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1C173D),
                    prefixIcon: Icon(
                      FontAwesomeIcons.inbox,
                      size: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),

              // InputWidget(
              //   icon: FontAwesomeIcons.inbox,
              //   label: "Email",
              //   controller: _emailcontroller,
              // ),
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
              Row(
                children: [
                  Text(
                    "Services you can provide",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                        fontSize: 12),
                  ),
                  IconButton(
                      onPressed: () {
                        // displayBottomSheet(context);
                        displayBottomCameraMenu(context, servicesList);
                      },
                      icon:
                          const Icon(Icons.edit, size: 20, color: Colors.grey)),
                ],
              ),
              Wrap(children: _buildChoiceList()),
              // MultiSelectChip(
              //   servicesList,
              //   onSelectionChanged: (selectedList) {
              //     setState(() {
              //       selectedServicesList = selectedList;
              //       // print(selectedMonthList);
              //     });
              //   },
              //   maxSelection: 7,
              // ),

              const SizedBox(height: 40),
              ButtonWidget(
                width: _width * 0.5,
                label: "Update Profile",
                onPress: () {
                  // Future signUp() async {
                  // try {
                  print("Profile updated...");
                  print(context.read<ChangeLocation>().destination);
                  try {
                    // print(context.watch<ChangeLocation>().foundLocation);
                    print(
                        "source: ${context.read<ChangeLocation>().destinationPosition}");
                    // print(context.watch<ChangeLocation>().foundSource);
                  } catch (e) {
                    print(e.toString());
                  } // print(context.watch<ChangeLocation>().sourceLocation);
                  // fetchUserFromFirestore();
                  // print(" uidis  ${fetchedUser["uid"]}");
                  GeoPoint destinationPos = GeoPoint(
                      context
                          .read<ChangeLocation>()
                          .destinationPosition
                          .latitude,
                      context
                          .read<ChangeLocation>()
                          .destinationPosition
                          .longitude);
                  var firebaseUser = FirebaseAuth.instance.currentUser;
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(firebaseUser?.uid)
                      .update({
                    "name": _namedcontroller.text,
                    "services": selectedServicesList,
                    "destination": destinationPos,
                  }).then((_) {
                    print("name ${_namedcontroller.text.trim()}");

                    print("Success updated Profile!");
                    Fluttertoast.showToast(
                        msg: "Profile Updated Succesfully!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.7),
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
