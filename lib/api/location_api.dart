// ignore_for_file: avoid_print

import 'dart:async';
import 'package:ekjut/wigets/place.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';

class LocationApi extends ChangeNotifier {
  List<Place> places = [];

  var addressController = TextEditingController();
  final _controller = StreamController<List<Place>>.broadcast();
  Stream<List<Place>> get controllerOut =>
      _controller.stream.asBroadcastStream();

  StreamSink<List<Place>> get controllerIn => _controller.sink;

  addPlace(Place place) {
    places.add(place);
    controllerIn.add(places);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  handleSearch(String query) async {
    try {
      print('Entered');
      List<Location> locations = await locationFromAddress(query);
      locations.forEach(
        (location) async {
          print(location);
          List<Placemark> placeMarks = await placemarkFromCoordinates(
              location.latitude, location.longitude);
          // await placemarkFromCoordinates(30.2602523, 77.0449321);

          for (var placemark in placeMarks) {
            print(placemark.name);
            addPlace(Place(
                name: placemark.name.toString(),
                street: placemark.street.toString(),
                locality: placemark.locality.toString(),
                country: placemark.country.toString()));
          }
        },
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
