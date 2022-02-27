// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'dart:async';

class Help extends ChangeNotifier {
  bool removePolyLine = false;
  List<Map<String, dynamic>> selectedService = [];
  List<Map<String, dynamic>> helps = [
    // {
    //   'description': 'accident happend',
    //   'service': 'Service 1',
    //   'distance': '100',
    //   'isSwipUp': false,
    //   'help': 'need ambulance',
    //   'name': 'xyx1',
    //   'isShow': false,
    //   'location': latLng.LatLng(28.9901953, 77.342768),
    // },
    {
      'description': 'accident happend',
      'service': 'Service 1',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx1',
      'isShow': false,
      'location': latLng.LatLng(28.9901953, 77.342768),
    },
    {
      'description': 'accident happend',
      'service': 'Service 1',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx1',
      'isShow': false,
      'location': latLng.LatLng(28.9901953, 77.342768),
    },
    {
      'description': 'accident happend',
      'service': 'Service 1',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx',
      'isShow': false,
      'location': latLng.LatLng(28.8901953, 77.342768),
    },
    {
      'description': 'accident happend',
      'service': 'Service 2',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx',
      'isShow': false,
      'location': latLng.LatLng(28.9901953, 77.342768),
    },
    {
      'description': 'accident happend',
      'service': 'Service 3',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx',
      'isShow': false,
      'location': latLng.LatLng(28.9901953, 77.342768),
    },
    {
      'description': 'accient happend',
      'service': 'Service 4',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx',
      'isShow': false,
      'location': latLng.LatLng(28.9901953, 77.342768),
    },
    {
      'description': 'accident happend',
      'service': 'Service 5',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx',
      'isShow': false,
      'location': latLng.LatLng(28.9901953, 77.342768),
    },
    {
      'description': 'accident happend',
      'service': 'Service 6',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx',
      'isShow': false,
      'location': latLng.LatLng(28.9901953, 77.342768),
    },
    {
      'description': 'accident happend',
      'service': 'Service 7',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx',
      'isShow': false,
      'location': latLng.LatLng(28.9901953, 77.342768),
    },
    {
      'description': 'accident happend',
      'service': 'Service 8',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx',
      'isShow': false,
      'location': latLng.LatLng(28.9901953, 77.342768),
    },
    {
      'description': 'accident happend',
      'service': 'Service 9',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx',
      'isShow': false,
      'location': latLng.LatLng(28.8901953, 77.342768),
    },
    {
      'description': 'accident happend',
      'service': 'Service 10',
      'distance': '100',
      'isSwipUp': false,
      'help': 'need ambulance',
      'name': 'xyx',
      'isShow': false,
      'location': latLng.LatLng(28.8901953, 77.342768),
    },
  ];

  List<Map<String, dynamic>> getService(String s) {
    selectedService.clear();
    List<Map<String, dynamic>> serviceList = [];
    for (int i = 0; i < helps.length; i++) {
      if (helps[i]["service"] == s) {
        serviceList.add(helps[i]);
        selectedService.add(helps[i]);
      }
    }
    return serviceList;
  }

  List<Map<String, dynamic>> temporaryHelpList = [];

  void addHelp(newhelp) {
    helps.add(newhelp);
    notifyListeners();
  }

  void deleteHelp(index) {
    helps.removeAt(index);
    notifyListeners();
  }

  // void updateDistance(int index, double distance) {
  //   helps[index]['distance'] = distance;
  //   print(helps[index]['distance']);
  // }

  void updateDistance(List<double> list) async {
    // if(helps[0]["location"] !=  '100') return;
    for (int i = 0; i < helps.length; i++) {
      latLng.LatLng location = helps[i]['location'];
      double distanceInMeters = await Geolocator.distanceBetween(
          list[0], list[1], location.latitude, location.longitude);
      helps[i]['distance'] = distanceInMeters.toInt();
    }
    notifyListeners();
  }

  Timer _timer = Timer(const Duration(seconds: 1), () {});

  // timer
  void startTimer(int index) {
    int _start = temporaryHelpList[index]["timer"];
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          helps.add({
            'description': temporaryHelpList[index]["description"],
            'distance': temporaryHelpList[index]["distance"],
            'help': temporaryHelpList[index]["help"],
            'name': temporaryHelpList[index]["name"],
            'isShow': false,
            'location': temporaryHelpList[index]["location"],
          });
          temporaryHelpList.removeAt(index);
          timer.cancel();
          removePolyLine = true;
          notifyListeners();
        } else {
          _start--;
        }
      },
    );
  }

  void helpDone() {
    print('inside help done');
    _timer.cancel();
    temporaryHelpList.removeLast();
    removePolyLine = true;
    notifyListeners();
  }

  // removing helpfrom help list and adding it to temporary list
  void removeHelpFromHelpList(int index) {
    temporaryHelpList.add({
      'description': helps[index]["description"],
      'distance': helps[index]["distance"],
      'help': helps[index]["help"],
      'name': helps[index]["name"],
      'isShow': false,
      'location': helps[index]["location"],
      'timer': 10
    });
    helps.removeAt(index);
    startTimer(index);
    notifyListeners();
  }
}
