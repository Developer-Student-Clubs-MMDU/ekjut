import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekjut/models/pointers_position.dart';
import 'package:ekjut/pages/map.dart';
import 'package:ekjut/pages/wating_help.dart';
import 'package:ekjut/wigets/userlocation.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:georange/georange.dart';
import 'package:ekjut/api/user_details.dart';
import 'package:ekjut/models/helps.dart';
import 'package:ekjut/models/user.dart';
import 'package:ekjut/pages/make_profile_page.dart';
import 'package:ekjut/pages/read_users.dart';
import 'package:ekjut/api/changing_location.dart';
import 'package:ekjut/api/helps.dart';
import 'package:ekjut/models/services.dart';
import 'package:ekjut/wigets/build_circle.dart';
import 'package:ekjut/wigets/build_people.dart';
import 'package:ekjut/wigets/button.dart';
import 'package:ekjut/wigets/circular_icon.dart';
import 'package:ekjut/wigets/help_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:ekjut/wigets/multi_choice.dart';
import 'package:ekjut/wigets/red_button.dart';
import 'package:ekjut/wigets/search_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwipeUp = false;
  bool isSwipeRight = false;
  bool isTap = false;
  int i = 0;
  late Range range;
  bool rangeValue = false;
  List<String> selectedServicesList = ['Donate Blood'];
  List<Map<String, dynamic>> serviceList = [];
  TextEditingController descriptionController = TextEditingController();
  List<Helps> helps = [];

  selectServices(String service) {
    serviceList = Provider.of<Help>(context, listen: false).getService(service);
  }

  createPointers(data, pointerPos) {
    for (int i = 0; i < data.length; i++) {
      Positioned(
        top: pointerPos[i][0],
        left: pointerPos[i][1],
        child: IconButton(
          color: Colors.purple,
          icon: const Icon(
            Icons.person_pin,
            size: 40,
          ),
          onPressed: () {
            // var help = Helps(
            //   desc: snapshot.data?.docs[index]["desc"],
            //   inProgress: false,
            //   locHash: snapshot.data?.docs[index]
            //       ["locHash"],
            //   location: snapshot.data?.docs[index]
            //       ["location"],
            //   uid: snapshot.data?.docs[index]["uid"],
            //   services: snapshot.data?.docs[index]
            //       ["services"],
            //   time: snapshot.data?.docs[index]["time"],
            // );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MapsPage(help: help),
            //   ),
            // );
          },
        ),
      );
    }
  }

  void addHelpToList() {
    latLng.LatLng loc = context.read<ChangeLocation>().helpPosition;
    if (loc == latLng.LatLng(28.6697905, 77.3439278)) {
      // TO DO -- CURRENT POSITION OF DEVICE BY DEFAULT
      loc = latLng.LatLng(28.6697905, 77.3439278);
    }
    context.read<Help>().addHelp({
      // 'description': descriptionController.text,
      'service': 'Service 1',
      'distance': '100',
      'isSwipUp': false,
      'help': 'xyz',
      'name': 'xyx1',
      'isShow': false,
      'location': loc,
    });
    // descriptionController.text = "";
    // context.read<ChangeLocation>().afterAddfHelp();
  }

  @override
  void initState() {
    super.initState();
    getlocation();
  }

  // Future fetchFiveHelps() {
  //   StreamBuilder(
  //     //Error number 2
  //     // stream: readHelps(showService, range, 5),
  //     stream: FirebaseFirestore.instance
  //         .collection("helps")
  //         .where("services", arrayContainsAny: [showService])
  //         .where("locHash", isGreaterThanOrEqualTo: range.lower)
  //         .where("locHash", isLessThanOrEqualTo: range.upper)
  //         .limit(10)
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return CircularProgressIndicator();
  //       } else if (snapshot.connectionState == ConnectionState.done) {
  //         return Text('done');
  //       } else if (snapshot.hasError) {
  //         return Text('Error!');
  //       } else {
  //         fivePointers.add(snapshot.data);
  //         print(fivePointers);
  //       }
  //       return fivePointers;
  //     }
  //   );
  // }

  List<double> list = [];
  Future getlocation() async {
    UserLocation location = UserLocation();
    list = await location.getUserLocation();
    print("xxxxxxxxxxxxxxxxxxxx$list");
    range = georange.geohashRange(list[0], list[1], distance: 10);
    setState(() {
      rangeValue = true;
    });
    return list;
  }

  String showService = "Car Pool";
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  // late Range range = georange.geohashRange(list[0], list[1], distance: 10);

  List<dynamic> fivePointers = [];
  List<dynamic> tempPointers = [];
  @override
  Widget build(BuildContext context) {
    // Future<void> addUser() {
    //   // print(context.watch<UserDetails>().uid);
    //   final userId = context.watch<UserDetails>().uid;
    //   print("inside add user function");
    //   print(userId);
    //   DocumentReference users =
    //       FirebaseFirestore.instance.doc('users/' + userId);
    //   return users
    //       .set({'uid': userId, 'company': "company", 'age': "age"})
    //       .then((value) => print("User Added"))
    //       .catchError((error) => print("Failed to add user: $error"));
    // }

    // TO DO : UPDATE LOCATION OF USER
    context.watch<Help>().updateDistance([0, 0]);

    final _userLocation = TextEditingController();

    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;
    // return StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance.collection("helps").snapshots(),
    //     // stream: readHelps(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    // if (snapshot.hasError) {
    //   return const Text("something went wrong");
    // } else if (snapshot.hasData) {
    //   print("inside the builder");
    //   final helps = snapshot.data!.docs
    //       .map((DocumentSnapshot document) => print(document["uid"]));
    //   // print(users"uid");
    //   // print("00000000000000 $users 0000000000000000");
    //   // return Scaffold(
    //   //     body: ListView(children: [
    //   //   Container(color: Colors.black12, height: 300, width: 300)
    //   // ]));
    // }
    // else {
    //   return const Scaffold(
    //       body: Center(child: CircularProgressIndicator()));
    // }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldState,
        drawer: Container(
          width: 250,
          child: Drawer(
            backgroundColor: Colors.transparent,
            child: ClipPath(
              child: Stack(
                children: [
                  Container(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 26.0, sigmaY: 26.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.1)),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Flexible(
                        child: ListView(padding: EdgeInsets.zero, children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CircleAvatar(radius: 30)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${FirebaseAuth.instance.currentUser!.email}",
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                // fontWeight: FontWeight.thin,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            // width: 70,
                            height: 0.1,
                            color: Colors.grey[300],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ListTile(
                              leading:
                                  Icon(Icons.home, color: Colors.grey[500]),
                              title: Text(
                                "Home",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 0.1,
                            color: Colors.grey[300],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MakeProfile()),
                              );
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.account_circle,
                                color: Colors.grey[500],
                              ),
                              title: Text(
                                "Profile",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500]),
                              ),
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 0.1,
                            color: Colors.grey[300],
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.comment,
                              color: Colors.grey[500],
                            ),
                            title: Text(
                              "About",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 0.1,
                            color: Colors.grey[300],
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Colors.grey[500],
                            ),
                            title: Text(
                              "Contact",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 0.1,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ]),
                      ),
                      Container(
                        // width: 70,
                        height: 0.2,
                        color: Colors.grey[300],
                      ),
                      InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              title: Text(
                                "Logout",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500]),
                              ),
                              leading: Icon(
                                Icons.logout,
                                color: Colors.grey[500],
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
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
          child: GestureDetector(
            onPanEnd: (details) {
              print(details.velocity.pixelsPerSecond.dy);
              print(details.velocity.pixelsPerSecond.dx);
              if (details.velocity.pixelsPerSecond.dy < -100) {
                setState(() {
                  // print("0000000000000");
                  // print(isSwipeUp);

                  isSwipeUp = true;
                  print("0000000000000");
                  print(isSwipeUp);
                });
              } else {
                setState(() {
                  isSwipeUp = false;

                  print("0000000000000");
                  print(isSwipeUp);
                });
              }
            },
            child: Stack(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              fit: StackFit.loose,
              children: [
                Positioned(
                  /// [Menu Button]
                  left: 0.0,
                  top: _height * 0.05,
                  child: Container(
                    height: _height * 0.05,
                    width: _width * 0.17,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            30,
                          ),
                          bottomRight: Radius.circular(30)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromRGBO(26, 41, 128, 100),
                            Color.fromRGBO(42, 178, 252, 90),
                          ]),
                    ),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        // print("signout");
                        _scaffoldState.currentState?.openDrawer();
                        // FirebaseAuth.instance.signOut();
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),

                IconWidget(
                  onPress: () {},
                  color: const Color(0xFF1C173D),
                  icon: FontAwesomeIcons.userAlt,
                  size: 20.0,
                ),

                // 1
                BuildCircle(opacity: 0.7, radius: _width * 0.35),
                //2
                BuildCircle(opacity: 0.6, radius: _width * 0.55),
                //3
                BuildCircle(opacity: 0.5, radius: _width * 0.80),
                //4
                BuildCircle(opacity: 0.3, radius: _width * 1.5),

                // stream builder for data
                // StreamBuilder(
                //     stream: FirebaseFirestore.instance
                //         .collection("helps")
                //         // .where("services", arrayContainsAny: [showService])
                //         // .where("locHash", isGreaterThanOrEqualTo: range.lower)
                //         // .where("locHash", isLessThanOrEqualTo: range.upper)
                //         // .limit(5)
                //         .snapshots(),
                //     builder: (BuildContext context,
                //         AsyncSnapshot<QuerySnapshot> snapshot) {
                //       print(
                //           '==========================================================');
                //       print(snapshot.data);
                //       print(snapshot.data?.docs);
                //       // snapshot.data?.docs.forEach((element) {
                //       //   print(element);
                //       // });
                //       if (!snapshot.hasData) return CircularProgressIndicator();
                //       var docs = snapshot.data?.docs;
                //       return ListView(
                //         children: docs == null
                //             ? [CircularProgressIndicator()]
                //             : docs.map((doc) {
                //                 print(doc);
                //                 return Text('hello');
                //               }).toList(),
                //       );
                //     }),
                StreamBuilder<QuerySnapshot>(
                    // stream: readHelps(showService, range, 5),
                    stream: FirebaseFirestore.instance
                        .collection("helps")
                        // .where("services", arrayContainsAny: [showService])
                        // .where("locHash", isGreaterThanOrEqualTo: range.lower)
                        // .where("locHash", isLessThanOrEqualTo: range.upper)
                        .limit(5)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      //  var docs = snapshot.data?.doc.map(doc => doc.data());
                      //  print(docs);
                      // print(
                      //     '=================================================================');
                      // print(snapshot.data);
                      // print(
                      //     '=================================================================');
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return CircularProgressIndicator();
                      // } else if (snapshot.connectionState ==
                      //     ConnectionState.done) {
                      //   return Text('done');
                      // } else
                      if (snapshot.hasError) {
                        return Text('Error!');
                      } else if (!snapshot.hasData) {
                        return Container();
                      }
                      // if(fivePointers.length == tempPointers.length){
                      //   fivePointers = tempPointers;
                      // }
                      // else
                      // tempPointers.add(snapshot.data);
                      // fivePointers = tempPointers;
                      // tempPointers = [];
                      //print every second: [0] then [0,1] then [0,1,2] ...

                      GeoRange georange = GeoRange();

                      int? len = snapshot.data?.docs.length;
                      len == null ? 0 : len;
                      for (int index = 0; index < len! + 0; index++) {
                        var help = Helps(
                          desc: snapshot.data?.docs[index]["desc"],
                          inProgress: false,
                          locHash: snapshot.data?.docs[index]["locHash"],
                          location: snapshot.data?.docs[index]["location"],
                          uid: snapshot.data?.docs[index]["uid"],
                          services: snapshot.data?.docs[index]["services"],
                          time: snapshot.data?.docs[index]["time"],
                        );
                        helps.add(help);
                      }
                      return Container();
                      // return ListView.builder(
                      //   itemBuilder: (context, index) {
                      //     // print(snapshot.data?.docs);
                      //     // print('***************************************************');
                      //     // print(pointerPos[index][0]);
                      //     // print(pointerPos[index][1]);
                      //     // print('***************************************************');
                      //     return Positioned(
                      //       top: pointerPos[index][0],
                      //       left: pointerPos[index][1],
                      //       child: IconButton(
                      //         color: Colors.purple,
                      //         icon: const Icon(
                      //           Icons.person_pin,
                      //           size: 40,
                      //         ),
                      //         onPressed: () {
                      //           var help = Helps(
                      //             desc: snapshot.data?.docs[index]["desc"],
                      //             inProgress: false,
                      //             locHash: snapshot.data?.docs[index]
                      //                 ["locHash"],
                      //             location: snapshot.data?.docs[index]
                      //                 ["location"],
                      //             uid: snapshot.data?.docs[index]["uid"],
                      //             services: snapshot.data?.docs[index]
                      //                 ["services"],
                      //             time: snapshot.data?.docs[index]["time"],
                      //           );
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => MapsPage(help: help),
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     );
                      //   },
                      //   itemCount: snapshot.data?.docs.length,
                      // );
                    }),
                helps.length <= 0
                    ? Container()
                    : Positioned(
                        top: pointerPos[0][0],
                        left: pointerPos[0][1],
                        child: IconButton(
                          color: Colors.purple,
                          icon: const Icon(
                            Icons.person_pin,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapsPage(help: helps[0]),
                              ),
                            );
                          },
                        ),
                      ),
                helps.length <= 0
                    ? Container()
                    : Positioned(
                        top: pointerPos[1][0],
                        left: pointerPos[1][1],
                        child: IconButton(
                          color: Colors.purple,
                          icon: const Icon(
                            Icons.person_pin,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapsPage(help: helps[1]),
                              ),
                            );
                          },
                        ),
                      ),
                helps.length <= 0
                    ? Container()
                    : Positioned(
                        top: pointerPos[2][0],
                        left: pointerPos[2][1],
                        child: IconButton(
                          color: Colors.purple,
                          icon: const Icon(
                            Icons.person_pin,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapsPage(help: helps[2]),
                              ),
                            );
                          },
                        ),
                      ),
                helps.length <= 0
                    ? Container()
                    : Positioned(
                        top: pointerPos[3][0],
                        left: pointerPos[3][1],
                        child: IconButton(
                          color: Colors.purple,
                          icon: const Icon(
                            Icons.person_pin,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapsPage(help: helps[3]),
                              ),
                            );
                          },
                        ),
                      ),
                // // StreamBuilder<QuerySnapshot>(
                //   // stream: readHelps(showService, range, 5),
                //   stream: FirebaseFirestore.instance
                //       .collection("helps")
                //       // .where("services", arrayContainsAny: [showService])
                //       // .where("locHash", isGreaterThanOrEqualTo: range.lower)
                //       // .where("locHash", isLessThanOrEqualTo: range.upper)
                //       .limit(5)
                //       .snapshots(),
                //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //     //  var docs = snapshot.data?.doc.map(doc => doc.data());
                //     //  print(docs);
                //     // print(
                //     //     '=================================================================');
                //     // print(snapshot.data);
                //     // print(
                //     //     '=================================================================');
                //     // if (snapshot.connectionState == ConnectionState.waiting) {
                //     //   return CircularProgressIndicator();
                //     // } else if (snapshot.connectionState ==
                //     //     ConnectionState.done) {
                //     //   return Text('done');
                //     // } else
                //     if (snapshot.hasError) {
                //       return Text('Error!');
                //     } else if (!snapshot.hasData) {
                //       return Container();
                //     }
                //     var data = snapshot.data?.docs;
                //     final int dataLength = data!.length;
                //     // for (var _widget in snapshot.data!.docs) {
                //     for (int i = 0; i < 5; i++) {
                //       Positioned(
                //         top: pointerPos[i][0],
                //         left: pointerPos[i][1],
                //         child: IconButton(
                //           color: Colors.purple,
                //           icon: const Icon(
                //             Icons.person_pin,
                //             size: 40,
                //           ),
                //           onPressed: () {
                //             // var help = Helps(
                //             //   desc: snapshot.data?.docs[index]["desc"],
                //             //   inProgress: false,
                //             //   locHash: snapshot.data?.docs[index]
                //             //       ["locHash"],
                //             //   location: snapshot.data?.docs[index]
                //             //       ["location"],
                //             //   uid: snapshot.data?.docs[index]["uid"],
                //             //   services: snapshot.data?.docs[index]
                //             //       ["services"],
                //             //   time: snapshot.data?.docs[index]["time"],
                //             // );
                //             // Navigator.push(
                //             //   context,
                //             //   MaterialPageRoute(
                //             //     builder: (context) => MapsPage(help: help),
                //             //   ),
                //             // );
                //           },
                //         ),
                //       );
                //     }
                //     // if(fivePointers.length == tempPointers.length){
                //     //   fivePointers = tempPointers;
                //     // }
                //     // else
                //     // tempPointers.add(snapshot.data);
                //     // fivePointers = tempPointers;
                //     // tempPointers = [];
                //     //print every second: [0] then [0,1] then [0,1,2] ...
                //     GeoRange georange = GeoRange();
                //     return (for(int i = 0; i < 5; i++) {
                //       Positioned(
                //         top: pointerPos[i][0],
                //         left: pointerPos[i][1],
                //         child: IconButton(
                //           color: Colors.purple,
                //           icon: const Icon(
                //             Icons.person_pin,
                //             size: 40,
                //           ),
                //           onPressed: () {
                //             // var help = Helps(
                //             //   desc: snapshot.data?.docs[index]["desc"],
                //             //   inProgress: false,
                //             //   locHash: snapshot.data?.docs[index]
                //             //       ["locHash"],
                //             //   location: snapshot.data?.docs[index]
                //             //       ["location"],
                //             //   uid: snapshot.data?.docs[index]["uid"],
                //             //   services: snapshot.data?.docs[index]
                //             //       ["services"],
                //             //   time: snapshot.data?.docs[index]["time"],
                //             // );
                //             // Navigator.push(
                //             //   context,
                //             //   MaterialPageRoute(
                //             //     builder: (context) => MapsPage(help: help),
                //             //   ),
                //             // );
                //           },
                //         ),
                //       );
                //     });
                //     // return ListView.builder(
                //     //   itemBuilder: (context, index) {
                //     //     // print(snapshot.data?.docs);
                //     //     // print('***************************************************');
                //     //     // print(pointerPos[index][0]);
                //     //     // print(pointerPos[index][1]);
                //     //     // print('***************************************************');

                //     //     return Positioned(
                //     //       top: pointerPos[index][0],
                //     //       left: pointerPos[index][1],
                //     //       child: IconButton(
                //     //         color: Colors.purple,
                //     //         icon: const Icon(
                //     //           Icons.person_pin,
                //     //           size: 40,
                //     //         ),
                //     //         onPressed: () {
                //     //           var help = Helps(
                //     //             desc: snapshot.data?.docs[index]["desc"],
                //     //             inProgress: false,
                //     //             locHash: snapshot.data?.docs[index]["locHash"],
                //     //             location: snapshot.data?.docs[index]
                //     //                 ["location"],
                //     //             uid: snapshot.data?.docs[index]["uid"],
                //     //             services: snapshot.data?.docs[index]
                //     //                 ["services"],
                //     //             time: snapshot.data?.docs[index]["time"],
                //     //           );
                //     //           Navigator.push(
                //     //             context,
                //     //             MaterialPageRoute(
                //     //               builder: (context) => MapsPage(help: help),
                //     //             ),
                //     //           );
                //     //         },
                //     //       ),
                //     //     );
                //     //   },
                //     //   itemCount: snapshot.data?.docs.length,
                //     // );

                //     // fivePointeRrs.clear();
                //   },
                // ),

                // const Positioned(
                //   top: 200,
                //   left: 200,
                //   child: BuildPeople(id: "Mohit", index: 0),
                // ),
                // const Positioned(
                //   top: 390,
                //   left: 230,
                //   child: BuildPeople(id: "Sakshi", index: 1),
                // ),
                // const Positioned(
                //   top: 300,
                //   left: 120,
                //   child: BuildPeople(id: "XYZ", index: 2),
                // ),
                // const Positioned(
                //   top: 450,
                //   left: 100,
                //   child: BuildPeople(id: "ABC", index: 3),
                // ),
                // const Positioned(
                //   top: 500,
                //   left: 200,
                //   child: BuildPeople(id: "QWDUI", index: 4),
                // ),

                AnimatedPositioned(
                  curve: Curves.decelerate,
                  top: _height * 0.1,
                  right: isSwipeRight
                      ? _width * 0.075
                      : -((_width * 0.80) - (_width * 0.01)),
                  duration: const Duration(milliseconds: 400),
                  child: GestureDetector(
                      onPanEnd: (details) {
                        print(details.velocity.pixelsPerSecond.dx.toString());
                        if (details.velocity.pixelsPerSecond.dx < -150) {
                          setState(() {
                            isSwipeRight = true;
                          });
                        } else if (details.velocity.pixelsPerSecond.dx > 150) {
                          setState(() {
                            isSwipeRight = false;
                          });
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _width * 0.03,
                            height: _height * 0.15,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors:
                                      // (isSwipeRight) ?
                                      //  [Color(0xFF1C173D)] :
                                      [
                                    Color.fromRGBO(40, 154, 231, 100),
                                    Color.fromRGBO(26, 94, 132, 100),
                                  ]),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                          Container(
                            width: _width * 0.80,
                            height: _height * 0.60,
                            padding: const EdgeInsets.all(20.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1C173D),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                            ),
                            // child: SingleChildScrollView(
                            //   child: SizedBox(
                            //     width: _width * 0.80,
                            //     height: _height * 0.60,
                            //     child: Column(
                            //       // mainAxisAlignment: MainAxisAlignment.start,
                            //       children: [
                            //         Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             const Text(
                            //               "Help",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   // fontFamily: "Roboto",
                            //                   fontWeight: FontWeight.w700,
                            //                   fontSize: 15),
                            //             ),
                            //             InkWell(
                            //               onTap: () {
                            //                 setState(() {
                            //                   isSwipeRight = false;
                            //                 });
                            //               },
                            //               child: const Icon(
                            //                 Icons.close,
                            //                 size: 24,
                            //                 color: Colors.white,
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //         // InputWidget(
                            //         //   icon: FontAwesomeIcons.map,
                            //         //   label: 'Location',
                            //         //   controller: _userLocation,
                            //         // ),
                            //         const SearchViewInput(),
                            //         const SizedBox(
                            //           height: 20.0,
                            //         ),
                            //         const Padding(
                            //           padding: EdgeInsets.all(8.0),
                            //           child: Align(
                            //             alignment: Alignment.centerLeft,
                            //             child: Text(
                            //               "Services:",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   // fontFamily: "Roboto",
                            //                   fontWeight: FontWeight.w700,
                            //                   fontSize: 15),
                            //             ),
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: ListView(
                            //             scrollDirection: Axis.horizontal,
                            //             shrinkWrap: false,
                            //             children: [
                            //               MultiSelectChip(
                            //                 servicesItem,
                            //                 onSelectionChanged: (selectedList) {
                            //                   setState(() {
                            //                     selectedServicesList =
                            //                         selectedList;
                            //                     // print(selectedMonthList);
                            //                   });
                            //                 },
                            //                 maxSelection: 1,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         const Padding(
                            //           padding: EdgeInsets.all(8.0),
                            //           child: Align(
                            //             alignment: Alignment.centerLeft,
                            //             child: Text(
                            //               "Description:",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   // fontFamily: "Roboto",
                            //                   fontWeight: FontWeight.w700,
                            //                   fontSize: 15),
                            //             ),
                            //           ),
                            //         ),
                            //         SingleChildScrollView(
                            //           child: TextField(
                            //             controller: descriptionController,
                            //             style: const TextStyle(
                            //                 color: Color(0xFFbdc6cf)),
                            //             decoration: const InputDecoration(
                            //               filled: true,
                            //               fillColor: Color(0xFF36306D),
                            //               border: OutlineInputBorder(),
                            //               hintText:
                            //                   'Enter a description of the help(optional)',
                            //             ),
                            //             keyboardType: TextInputType.multiline,
                            //             // maxLines: 4,
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceBetween,
                            //             children: [
                            //               RedButton(
                            //                 width: _width * 0.3,
                            //                 label: "Cancel",
                            //                 onPress: () {
                            //                   isSwipeRight = false;
                            //                 },
                            //               ),
                            //               ButtonWidget(
                            //                 width: _width * 0.3,
                            //                 label: "Help",
                            //                 onPress: () {
                            //                   isSwipeRight = false;
                            //                   // addHelpToList();
                            //                   setState(() {
                            //                     print(descriptionController.text
                            //                         .trim());
                            //                     createHelp();
                            //                   });
                            //                 },
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),

                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Help",
                                      style: TextStyle(
                                          color: Colors.white,
                                          // fontFamily: "Roboto",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isSwipeRight = false;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                // PhysicalModel(
                                //   color: Color(0xFF1C173D),
                                //   borderRadius: BorderRadius.circular(12.0),
                                //   elevation: 3.5,
                                //   child: TextField(
                                //       controller: _userLocation,
                                //       decoration: InputDecoration(
                                //           label: Text("Location"))),
                                // ),
                                // InputWidget(
                                //   icon: FontAwesomeIcons.map,
                                //   label: 'Location',
                                //   controller: _userLocation,
                                // ),

                                const SearchViewInput(),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Services:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          // fontFamily: "Roboto",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  child: Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        MultiSelectChip(
                                          servicesItem,
                                          onSelectionChanged: (selectedList) {
                                            setState(() {
                                              selectedServicesList =
                                                  selectedList;
                                              // print(selectedMonthList);
                                            });
                                          },
                                          maxSelection: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8.0, left: 8.0, right: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Description:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          // fontFamily: "Roboto",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                TextField(
                                  controller: descriptionController,
                                  style:
                                      const TextStyle(color: Color(0xFFbdc6cf)),
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFF36306D),
                                    border: OutlineInputBorder(),
                                    hintText:
                                        'Enter a description of the help(optional)',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RedButton(
                                        width: _width * 0.3,
                                        label: "Cancel",
                                        onPress: () {
                                          isSwipeRight = false;
                                        },
                                      ),
                                      ButtonWidget(
                                        width: _width * 0.3,
                                        label: "Help",
                                        onPress: () {
                                          isSwipeRight = false;
                                          // addHelpToList();
                                          setState(() {
                                            print(descriptionController.text
                                                .trim());
                                            createHelp();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                AnimatedPositioned(
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 400),
                  bottom: isSwipeUp
                      ? 0.0
                      : (isTap ? -(_height) : -(_height * 0.25)),
                  child: GestureDetector(
                    onPanEnd: (details) {
                      print(details.velocity.pixelsPerSecond.dy.toString());
                      print(details.velocity.pixelsPerSecond.dx.toString());
                      if (details.velocity.pixelsPerSecond.dy < -100) {
                        setState(() {
                          isSwipeUp = true;
                        });
                      } else {
                        setState(() {
                          isSwipeUp = false;
                        });
                      }
                    },
                    child: Container(
                      height: _height * 0.45,
                      width: _width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xFF1A2980),
                          Color(0xFF2AB2FC),
                        ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Search to help",
                                  style: TextStyle(
                                      color: Colors.white,
                                      // fontFamily: "Roboto",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                (isSwipeUp)
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSwipeUp = false;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.expand_more_outlined,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSwipeUp = true;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.expand_less_outlined,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      )
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: servicesItem.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IconWidget(
                                            color: Colors.red,
                                            icon: Icons.food_bank,
                                            onPress: () {
                                              print(
                                                  'Inside Service Categories');
                                              i = index;
                                              selectServices(
                                                  servicesItem[index]);
                                              setState(() {
                                                print("before $showService");
                                                showService =
                                                    servicesItem[index];
                                                print("after $showService");

                                                isSwipeUp = true;
                                                serviceItemSwipUp[index] = true;
                                              });
                                            },
                                          ),
                                        ),
                                        Text(
                                          servicesItem[index],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            // const ExpansionTile(
                            //   backgroundColor: Colors.green,
                            //   collapsedBackgroundColor: Colors.yellow,
                            //   title: Text(
                            //     "Distance",
                            //     style: TextStyle(
                            //         fontSize: 16.0,
                            //         fontWeight: FontWeight.w500),
                            //   ),
                            //   subtitle: Text("help.services"),
                            //   children: <Widget>[
                            //     Padding(
                            //       padding: EdgeInsets.only(
                            //           left: 18.0, bottom: 8.0),
                            //       child: Align(
                            //           alignment: Alignment.centerLeft,
                            //           child: Text("data")),
                            //     ),
                            //   ],
                            // ),

                            rangeValue == false
                                ? Container()
                                : StreamBuilder<List<Helps>>(
                                    stream: readHelps(showService, range, 10),
                                    builder: (context, snapshot) {
                                      print("0000000000000 $showService");
                                      print("00000000000000000000000000");

                                      print(snapshot);
                                      print(snapshot.hasData);
                                      print("00000000000000000000000000");

                                      if (snapshot.hasError) {
                                        // print("000000000000000000000000");
                                        return Text(
                                            "something went wrong ${snapshot.error}");
                                      } else if (snapshot.hasData) {
                                        print("has data");
                                        final helps = snapshot.data!;
                                        print(
                                            "currently data fetching is $helps");
                                        return Container(
                                          height: 500 - 232 - 92,
                                          child: ListView(
                                            children:
                                                // helps.map(buildHelp).toList(),
                                                helps
                                                    .map((value) => buildHelp(
                                                        value, context))
                                                    .toList(),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  )

                            // isSwipeUp && serviceItemSwipUp[i]
                            //     ? Expanded(
                            //         child: HelpList(
                            //           service: servicesItem[i],
                            //           serviceList: serviceList,
                            //         ),
                            //       )
                            //     : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // }
    // );
  }

  void createHelp() {
    // final geo = Geoflutterfire();
    GeoRange georange = GeoRange();

    final user = FirebaseAuth.instance.currentUser;
    print(
        '===========================================================================================');
    print(user);
    print(
        '===========================================================================================');
    latLng.LatLng loc = context.read<ChangeLocation>().helpPosition;
    // GeoFirePoint location =
    // geo.point(latitude: loc.latitude, longitude: loc.longitude);
    String locHash =
        georange.encode(loc.longitude + 0.001, loc.latitude - 0.00001);
    final GeoPoint location =
        GeoPoint(loc.latitude + 0.001, loc.longitude - 0.00001);
    if (user != null) {
      String x = "PLKDopw91yhWrARRaEppv3Ngu6r1";
      // print(descriptionController.text);
      print("enetr the body of create help");
      FirebaseFirestore.instance
          .collection("helps")
          .doc(user.uid)
          // .doc(x)
          .set({
            'uid': user.uid,
            // "uid": x,
            "desc": descriptionController.text,
            'inProgress': false,
            'location': location,
            "locHash": locHash,
            "services": selectedServicesList,
            "time": DateTime.now(),
          })
          .then((value) => print("Help Created"))
          .catchError((error) => print("Failed to Create user: $error"));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WatingHelp()));
    }
  }
}

class SearchViewInput extends StatelessWidget {
  const SearchViewInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SearchView(
          hintText: 'Location',
          wantSuggestions: false,
          indicatorNode: 2,
          isPadding: false),
    );
  }
}
