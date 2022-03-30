import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekjut/api/helps.dart';
import 'package:ekjut/models/helps.dart';
import 'package:ekjut/pages/homepage.dart';
import 'package:ekjut/wigets/userlocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';
import 'dart:async';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/routing.dart' as here;
import 'package:here_sdk/routing.dart';
import 'dart:async';

class MapsPage extends StatefulWidget {
  final Helps help;

  MapsPage({required this.help});

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  List<double> list = [];
  List<latLng.LatLng> locationList = [];

  // for here sdk and navigation
  late here.RoutingEngine _routingEngine;
  bool showNavigation = false;
  bool acknowledgedHelp = false;
  late HereMapController _hereMapController;
  List<String> navigation = [];
  int timeElapsed = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocation();
  }

// getting user's location
  void getlocation() async {
    UserLocation location = UserLocation();
    list = await location.getUserLocation();

    locationList.add(latLng.LatLng(list[0], list[1]));

    setState(() {});
  }

  void moveCamera(latLng.LatLng location, int i) {
    List<Map<String, dynamic>> helps = context.read<Help>().helps;
    _hereMapController.pinWidget(
        GestureDetector(
          onTap: ()async {
            if (helps.isEmpty) return;
            double distanceInMeters = await Geolocator.distanceBetween(
          list[0], list[1], widget.help.location.latitude, widget.help.location.longitude);
      helps[i]['distance'] = distanceInMeters.toInt();
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                content: Container(
                  height: 200,
                  width: 200,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Help : ${widget.help.desc.toString()}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            )),
                        Text(
                            'Distance From You : ${distanceInMeters.toString()}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                callAddRoute(widget.help.location.latitude,
                                    widget.help.location.longitude);
                                // removeItemFromHelpList(widget.index);
                                acknowledgedHelp = true;
                                // checkHelper();
                                setState(() {});
                                Navigator.pop(ctx);
                              },
                              child: const Text('Acknowlege'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                              child: const Text('Cancel'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.black,
            size: 40.0,
          ),
        ),
        GeoCoordinates(location.latitude, location.longitude));
    _hereMapController.camera.lookAtPointWithDistance(
        GeoCoordinates(location.latitude, location.longitude), 5000);
  }
  // function for adding help

  void addHelpToList(String help, String desc) {
    latLng.LatLng location = locationList[0];
    context.read<Help>().addHelp({
      'description': desc,
      'distance': '0',
      'help': help,
      'name': 'name',
      'isShow': false,
      'location': location
    });
  }

  // removing help form list -----> calling like this as provider cant be used outside widget tree
  void removeItemFromHelpList(index) {
    context.read<Help>().removeHelpFromHelpList(index);
  }

  void callAddRoute(double x, double y) {
    addRoute(x, y);
  }

  Future<void> addRoute(double x, double y) async {
    var startGeoCoordinates = GeoCoordinates(list[0], list[1]);
    var destinationGeoCoordinates = GeoCoordinates(x, y);
    // _hereMapController.pinWidget(
    //     const Icon(
    //       Icons.location_on,
    //       color: Colors.black,
    //       size: 40.0,
    //     ),
    //     GeoCoordinates(x, y));
    var startWaypoint = here.Waypoint.withDefaults(startGeoCoordinates);
    var destinationWaypoint =
        here.Waypoint.withDefaults(destinationGeoCoordinates);

    List<here.Waypoint> waypoints = [startWaypoint, destinationWaypoint];
    here.RoutingError routingError;
    List<here.Route> routeList;

    _routingEngine.calculateCarRoute(waypoints, here.CarOptions.withDefaults(),
        (routingError, routeList) {
      if (routingError == null) {
        if (routeList != null) {
          here.Route route = routeList.first;
          int totalEstimatedTime = route.durationInSeconds;
          _showRouteOnMap(route);
          _logRouteViolations(route);

          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            FirebaseFirestore.instance
                .collection("helps")
                .doc(widget.help.uid)
                .update({
                  "helperUid": user.uid,
                  "helperPosition": GeoPoint(list[0], list[1]),
                  "inProgress": true,
                  "helperStartedHelp": Timestamp.now(),
                  "estimatedTime": 1500
                  // "estimatedTime": totalEstimatedTime
                })
                .then((value) => print('Done Updating'))
                .catchError((onError) => print(onError));
          }
        }
        // _showRouteDetails(route);
      } else {
        var error = routingError.toString();
        Fluttertoast.showToast(msg: error);
        // showDialog('Error', 'Error while calculating a route: $error');
      }
    });
  }

  // void callRoutes(
  _showRouteOnMap(route) {
    // Show route as polyline.
    GeoPolyline routeGeoPolyline = GeoPolyline(route.polyline);

    double widthInPixels = 20;
    MapPolyline routeMapPolyline = MapPolyline(
        routeGeoPolyline, widthInPixels, Color.fromARGB(160, 0, 144, 138));

    _hereMapController.mapScene.addMapPolyline(routeMapPolyline);

    int estimatedTotalTrafficDelay = route.trafficDelayInSeconds;
    print('Estimated time = $estimatedTotalTrafficDelay');

    List<Section> sections = route.sections;
    for (Section section in sections) {
      _logManeuverInstructions(section);
    }
  }

  void _logManeuverInstructions(Section section) {
    print("Log maneuver instructions per route section:");
    List<Maneuver> maneuverInstructions = section.maneuvers;
    for (Maneuver maneuverInstruction in maneuverInstructions) {
      ManeuverAction maneuverAction = maneuverInstruction.action;
      GeoCoordinates maneuverLocation = maneuverInstruction.coordinates;
      String maneuverInfo = maneuverInstruction.text +
          ", Action: " +
          maneuverAction.toString() +
          ", Location: " +
          maneuverLocation.toString();
      String shortNav = maneuverInfo.split('Action')[0];
      navigation.add(shortNav);
      print(maneuverInfo);
    }

    showNavigation = true;
    setState(() {});
  }

  // A route may contain several warnings, for example, when a certain route option could not be fulfilled.
  void _logRouteViolations(here.Route route) {
    for (var section in route.sections) {
      for (var notice in section.sectionNotices) {
        Fluttertoast.showToast(
            msg: "This route contains the following warning: " +
                notice.code.toString());
        print("This route contains the following warning: " +
            notice.code.toString());
      }
    }
  }

  // showing here map
  void _onMapCreated(HereMapController hereMapController) {
    _hereMapController = hereMapController;

    _hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error != null) {
        Fluttertoast.showToast(
            msg: 'Map scene not loaded. MapError: ${error.toString()}');
        // print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 8000;
      hereMapController.camera.lookAtPointWithDistance(
          GeoCoordinates(list[0], list[1]), distanceToEarthInMeters);
      hereMapController.pinWidget(
          const Icon(
            Icons.person_pin,
            size: 40,
            color: Colors.purple,
          ),
          // const Icon(
          //   Icons.location_on,
          //   color: Colors.black,
          //   size: 40.0,
          // ),
          GeoCoordinates(list[0], list[1]));
      moveCamera(
          latLng.LatLng(
              widget.help.location.latitude, widget.help.location.longitude),
          0);
    });

    try {
      _routingEngine = here.RoutingEngine();
      // ignore: nullable_type_in_catch_clause
    } on InstantiationException {
      throw ("Initialization of RoutingEngine failed.");
    }
  }

  // function to check whether the helper has taken more time from estimated time or not
  late Timer _timer;
  // void checkHelper() {
  //   int startTime = Timestamp.now().seconds;
  //   int estimatedTime = 0;
  //   FirebaseFirestore.instance
  //       .collection("helps")
  //       .doc(widget.help.uid)
  //       .get()
  //       .then((snapshot) {
  //     startTime = snapshot.data()!["helperStartedHelp"].seconds;
  //     estimatedTime = snapshot.data()!["estimatedTime"];
  //   });

  //   int totalTime = startTime + estimatedTime + 50;
  //   print('$startTime , $estimatedTime , $totalTime');
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(oneSec, (Timer timer) {
  //     int now = Timestamp.now().seconds;
  //     setState(() {
  //       timeElapsed = totalTime - now;
  //     });
  //     if (totalTime <= now) {
  //       print('$startTime , $estimatedTime , $totalTime');
  //       print('${totalTime} , ${now}, ${totalTime - now} ');
  //       print('cancellled');
  //       _timer.cancel();
  //       confirmHelper(estimatedTime);
  //     } else {
  //       print('$startTime , $estimatedTime , $totalTime');
  //       print('Time remaining ${totalTime} , ${now}, ${totalTime - now}');
  //     }
  //   });
  // }

  void confirmHelper(int estimatedTime) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Still Want to Help??'),
            content: const Text(
                'You have taken more than estimated. Press Ok if you want to still help'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    FirebaseFirestore.instance
                        .collection("helps")
                        .doc(widget.help.uid)
                        .update({
                      "inProgress": false,
                      "helperUid": "",
                      "estimatedTime": 0,
                      "helperStartedHelp": "none"
                    });
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("helps")
                      .doc(widget.help.uid)
                      .update({
                    "estimatedTime": estimatedTime + 50,
                  });
                  // checkHelper();
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: timeElapsed > -1
            ? Text('TREF $timeElapsed')
            : Text('Help Needy One :)'),
      ),
      body: SafeArea(
        child: list.length == 0
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Expanded(child: HereMap(onMapCreated: _onMapCreated)),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: acknowledgedHelp
                        ? FloatingActionButton(
                            onPressed: () {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                FirebaseFirestore.instance
                                    .collection("helps")
                                    .doc(widget.help.uid)
                                    .update({
                                  "inProgress": false,
                                  "helperUid": "",
                                  "estimatedTime": 0,
                                  "helperStartedHelp": "none"
                                });
                              }
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                            child: Icon(Icons.cancel_outlined),
                          )
                        : Container(),
                  ),
                ],
              ),
      ),
    );
  }
}
