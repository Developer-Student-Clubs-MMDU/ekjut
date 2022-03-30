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


class OnGoingHelpPage extends StatefulWidget {
  final list;
  OnGoingHelpPage({required this.list});

  @override
  _OnGoingHelpPageState createState() => _OnGoingHelpPageState();
}

class _OnGoingHelpPageState extends State<OnGoingHelpPage> {
  List<double> list = [28.670790500000003,77.3439178];
  List<latLng.LatLng> locationList = [];

  // for here sdk and navigation
  late here.RoutingEngine _routingEngine;
  bool showNavigation = false;
  bool acknowledgedHelp = false;
  late HereMapController _hereMapController;
  List<String> navigation = [];
  int timeElapsed = -1;
  late final user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> addRoute(double x, double y) async {
    var startGeoCoordinates = GeoCoordinates(list[0], list[1]);
    var destinationGeoCoordinates = GeoCoordinates(x, y);
    var startWaypoint = here.Waypoint.withDefaults(startGeoCoordinates);
    var destinationWaypoint =
        here.Waypoint.withDefaults(destinationGeoCoordinates);

    List<here.Waypoint> waypoints = [startWaypoint, destinationWaypoint];
    here.RoutingError routingError;
    List<here.Route> routeList;

     _hereMapController.pinWidget(
          const Icon(
            Icons.location_on,
            size: 40,
            color: Colors.black,
          ),
          GeoCoordinates(x,y));

    _routingEngine.calculateCarRoute(waypoints, here.CarOptions.withDefaults(),
        (routingError, routeList) {
      if (routingError == null) {
        if (routeList != null) {
          here.Route route = routeList.first;
          int totalEstimatedTime = route.durationInSeconds;
          _showRouteOnMap(route);
          _logRouteViolations(route);
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

    // showNavigation = true;
    setState(() {
      acknowledgedHelp = true;
    });
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
    // list = widget.list;
    _hereMapController = hereMapController;

    _hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error != null) {
        Fluttertoast.showToast(
            msg: 'Map scene not loaded. MapError: ${error.toString()}');
        // print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      user = FirebaseAuth.instance.currentUser;
      GeoPoint helperPosition;
      FirebaseFirestore.instance
          .collection('helps')
          // .doc("PLKDopw91yhWrARRaEppv3Ngu6r1")
          .doc(user.uid)
          .get()
          .then((snapshot) {
        helperPosition = snapshot.data()!["helperPosition"];
        checkHelper();
        print(
            '=============================================================================');
        print('${helperPosition.latitude},${helperPosition.longitude},${list[0]},${list[1]}');
        print(
            '=============================================================================');
        addRoute(helperPosition.latitude, helperPosition.longitude);
      }).catchError((onError) => {print(onError)});

      const double distanceToEarthInMeters = 8000;
      hereMapController.camera.lookAtPointWithDistance(
          GeoCoordinates(list[0], list[1]), distanceToEarthInMeters);
      hereMapController.pinWidget(
          const Icon(
            Icons.location_on,
            size: 40,
            color: Colors.red,
          ),
          GeoCoordinates(list[0], list[1]));
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
  void checkHelper() {
    int startTime = Timestamp.now().seconds;
    int estimatedTime = 0;
    FirebaseFirestore.instance
        .collection("helps")
        // .doc("PLKDopw91yhWrARRaEppv3Ngu6r1")
        .doc(user.uid)
        .get()
        .then((snapshot) {
      startTime = snapshot.data()!["helperStartedHelp"].seconds;
      estimatedTime = snapshot.data()!["estimatedTime"];
    });

    int totalTime = startTime + estimatedTime + 50;
    print('$startTime , $estimatedTime , $totalTime');
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      int now = Timestamp.now().seconds;
      setState(() {
        timeElapsed = (totalTime - now).abs();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: timeElapsed > -1
            ? Text('Expected Time $timeElapsed s')
            : Text('SomeOne Helping You :)'),
      ),
      body: SafeArea(
        child: widget.list.length == 0
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
                              FirebaseFirestore.instance
                                  .collection('helps')
                                  .doc(user?.uid)
                                  .delete();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            },
                            child: const Icon(Icons.done_outline_outlined),
                          )
                        : Container(),
                  ),
                ],
              ),
      ),
    );
  }
}
