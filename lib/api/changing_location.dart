// ignore_for_file: unused_import, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:geocoding/geocoding.dart';

class ChangeLocation extends ChangeNotifier {
  bool foundLocation = false;

  String source = '', destination = '', helpPos = '';
  bool foundSource = false, foundDestination = false, alreadyAddedPAth = false;
  latLng.LatLng userLocation = latLng.LatLng(28.6697905, 77.3439278);
  latLng.LatLng sourcePosition = latLng.LatLng(28.6697905, 77.3439278);
  latLng.LatLng destinationPosition = latLng.LatLng(28.6697905, 77.3439278);
  latLng.LatLng helpPosition = latLng.LatLng(28.6697905, 77.3439278);

  afterAddHelp() {
    helpPos = '';
    helpPosition = latLng.LatLng(28.6697905, 77.3439278);
  }

  getUserLocation(latLng.LatLng pos) {
    userLocation = pos;
    sourcePosition = userLocation;
    destinationPosition = userLocation;
    notifyListeners();
  }

  sourceLocation(String value) {
    foundLocation = true;
    source = value;
    foundSource = true;
    if (destination == '') {
      destination = 'Your Current Position';
      // List<Placemark> placeMarks = await placemarkFromCoordinates(
      //     userLocation.latitude, userLocation.longitude);
      // destination = '${placeMarks[0].name}, ${placeMarks[0].street}, ${placeMarks[0].country}';
    }
    notifyListeners();
  }

  destinationLocation(String value) {
    foundLocation = true;
    destination = value;
    foundDestination = true;
    if (source == '') {
      source = 'Your Current Position';
    }
    notifyListeners();
  }

  helpLocation(String value) {
    helpPos = value;
    print('inside help location');
    print(value);
    notifyListeners();
  }

  sourceLocationPosition(String address) async {
    List<Location> locations = await locationFromAddress(address);
    sourcePosition =
        latLng.LatLng(locations[0].latitude, locations[0].longitude);
    notifyListeners();
  }

  destinationLocationPosition(String address) async {
    List<Location> locations = await locationFromAddress(address);
    destinationPosition =
        latLng.LatLng(locations[0].latitude, locations[0].longitude);
    notifyListeners();
  }

  helpLocationPosition(String address) async {
    List<Location> locations = await locationFromAddress(address);
    helpPosition = latLng.LatLng(locations[0].latitude, locations[0].longitude);
    notifyListeners();
  }
}
