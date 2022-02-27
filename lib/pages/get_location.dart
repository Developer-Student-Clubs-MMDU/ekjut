import 'package:ekjut/api/changing_location.dart';
import 'package:ekjut/pages/get_timings.dart';
import 'package:ekjut/pages/signup_page.dart';
import 'package:ekjut/wigets/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as map;
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:provider/src/provider.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/routing.dart' as here;
import 'package:here_sdk/routing.dart';

class GetMyLocation extends StatefulWidget {
  final List<double> list;

  const GetMyLocation({Key? key, required this.list}) : super(key: key);

  @override
  _GetMyLocationState createState() => _GetMyLocationState();
}

class _GetMyLocationState extends State<GetMyLocation> {
  List<double> locationList = [];

  // for here sdk and navigation
  late here.RoutingEngine _routingEngine;
  bool showNavigation = false;
  late HereMapController _hereMapController;
  List<String> navigation = [];
  late MapPolyline routeMapPolyline;

  bool mapHasCreated = false;

  bool alreadyShown = false;

  bool yourLocationSuggetsions = false, sourceLocationSuggestions = false;

  @override
  Widget build(BuildContext context) {
    // if source and destination is not been selected yet
    if (context.watch<ChangeLocation>().foundSource == false &&
        context.watch<ChangeLocation>().foundDestination == false) {
      locationList.clear();

      // adding location
      locationList.add(widget.list[0]);
      locationList.add(widget.list[1]);
    } else if (context.watch<ChangeLocation>().foundSource &&
        context.watch<ChangeLocation>().foundDestination) {
      locationList.clear();

      // adding location
      locationList.add(context.read<ChangeLocation>().sourcePosition.latitude);
      locationList.add(context.read<ChangeLocation>().sourcePosition.longitude);
      locationList
          .add(context.read<ChangeLocation>().destinationPosition.latitude);
      locationList
          .add(context.read<ChangeLocation>().destinationPosition.longitude);
    }

    // if destination is not been selected
    else if (context.watch<ChangeLocation>().foundSource) {
      locationList.clear();
      locationList.add(context.read<ChangeLocation>().sourcePosition.latitude);
      locationList.add(context.read<ChangeLocation>().sourcePosition.longitude);
      locationList.add(widget.list[0]);
      locationList.add(widget.list[1]);
    }

    // if source is not been selected
    else if (context.watch<ChangeLocation>().foundDestination) {
      locationList.clear();
      locationList.add(widget.list[0]);
      locationList.add(widget.list[1]);
      locationList
          .add(context.read<ChangeLocation>().destinationPosition.latitude);
      locationList
          .add(context.read<ChangeLocation>().destinationPosition.longitude);
    }

    // void callRoutes(
    _showRouteOnMap(route) {
      // Show route as polyline.

      GeoPolyline routeGeoPolyline = GeoPolyline(route.polyline);

      double widthInPixels = 20;
      routeMapPolyline = MapPolyline(
          routeGeoPolyline, widthInPixels, Color.fromARGB(160, 0, 144, 138));

      _hereMapController.mapScene.addMapPolyline(routeMapPolyline);

      // context.read<ChangeLocation>().alreadyAddedPAth = true;
    }

    Future<void> addRoute(
        double sourcex, double sourcey, double destx, double desty) async {
      var startGeoCoordinates = GeoCoordinates(sourcex, sourcey);
      var destinationGeoCoordinates = GeoCoordinates(destx, desty);

      _hereMapController.pinWidget(
          const Icon(
            Icons.location_on,
            color: Colors.black,
            size: 40.0,
          ),
          GeoCoordinates(sourcex, sourcey));

      _hereMapController.pinWidget(
          const Icon(
            Icons.location_on,
            color: Colors.black,
            size: 40.0,
          ),
          GeoCoordinates(destx, desty));

      var startWaypoint = here.Waypoint.withDefaults(startGeoCoordinates);
      var destinationWaypoint =
          here.Waypoint.withDefaults(destinationGeoCoordinates);

      List<here.Waypoint> waypoints = [startWaypoint, destinationWaypoint];
      here.RoutingError routingError;
      List<here.Route> routeList;
      _routingEngine.calculateCarRoute(
          waypoints, here.CarOptions.withDefaults(), (routingError, routeList) {
        if (routingError == null) {
          if (routeList != null) {
            here.Route route = routeList.first;
            _showRouteOnMap(route);
          }
        } else {
          var error = routingError.toString();
          // showDialog('Error', 'Error while calculating a route: $error');
        }
      });
    }

    void callAddRoute(
        double sourcex, double sourcey, double destx, double desty) {
      print('call routes called');
      addRoute(sourcex, sourcey, destx, desty);
    }

    void afterMapCreation() {
      if (locationList.length >= 4) {
        callAddRoute(
            locationList[0], locationList[1], locationList[2], locationList[3]);
      }

      if (context.read<ChangeLocation>().alreadyAddedPAth) {
        print('removed');
        _hereMapController.mapScene.removeMapPolyline(routeMapPolyline);
      }

      List<WidgetPin> pin = _hereMapController.widgetPins;
      for (int j = 0; j < pin.length; j++) {
        _hereMapController.unpinWidget(pin[j].child);
      }

      for (int i = 0; i < locationList.length; i += 2) {
        _hereMapController.pinWidget(
            const Icon(
              Icons.location_on,
              color: Colors.black,
              size: 40.0,
            ),
            GeoCoordinates(locationList[i], locationList[i + 1]));

        if (i == 0) {
          _hereMapController.camera.lookAtPointWithDistance(
              GeoCoordinates(locationList[i], locationList[i + 1]), 8000);
        }
      }
    }

    // showing here map
    void _onMapCreated(HereMapController hereMapController) {
      _hereMapController = hereMapController;
      print('map created');
      // adding circles to map

      _hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
          (MapError? error) {
        if (error != null) {
          Fluttertoast.showToast(
              msg: 'Map scene not loaded. MapError: ${error.toString()}');
          return;
        }
      });

      try {
        _routingEngine = here.RoutingEngine();
        // ignore: nullable_type_in_catch_clause
      } on InstantiationException {
        throw ("Initialization of RoutingEngine failed.");
      }
      mapHasCreated = true;
      afterMapCreation();
    }

    if (mapHasCreated) {
      afterMapCreation();
    }
    return Scaffold(
      backgroundColor: const Color(0xFF36306D).withOpacity(1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            context.watch<ChangeLocation>().foundLocation
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GetMyTimings()
                                // : const SignupScreen(),
                                ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Text(
                        'Select Your Timings ',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
                : Container(),
            SearchView(
              wantSuggestions: yourLocationSuggetsions,
              hintText: 'Your Current  Location',
              indicatorNode: 0,
            ),
            SearchView(
              wantSuggestions: sourceLocationSuggestions,
              hintText: 'Destination Location ',
              indicatorNode: 1,
            ),
            Expanded(child: HereMap(onMapCreated: _onMapCreated))
          ],
        ),
      ),
    );
  }
}
