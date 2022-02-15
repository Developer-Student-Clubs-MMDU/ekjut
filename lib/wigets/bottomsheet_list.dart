import 'package:flutter/material.dart';

class ButtonSheetInfo {
  Widget widget;
  String name;
  ButtonSheetInfo({required this.name, required this.widget});
}

List<ButtonSheetInfo> listBottomSheet = [
  ButtonSheetInfo(
      name: "Food",
      widget: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.pink, borderRadius: BorderRadius.circular(50)),
          child: const Icon(
            Icons.restaurant_outlined,
            size: 35,
            color: Colors.white,
          ))),
  ButtonSheetInfo(
      name: "Car Pool",
      widget: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.pink, borderRadius: BorderRadius.circular(50)),
          child: const Icon(
            Icons.directions_car_filled,
            color: Colors.white,
            size: 35,
          ))),
  ButtonSheetInfo(
      name: "Medical Assit",
      widget: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.pink, borderRadius: BorderRadius.circular(50)),
          child: const Icon(
            Icons.medical_services,
            color: Colors.white,
            size: 35,
          ))),
  ButtonSheetInfo(
      name: "Volunteering",
      widget: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.pink, borderRadius: BorderRadius.circular(50)),
          child: const Icon(
            Icons.volunteer_activism,
            size: 35,
            color: Colors.white,
          ))),
  ButtonSheetInfo(
      name: "Service 1",
      widget: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.pink, borderRadius: BorderRadius.circular(50)),
          child: const Icon(
            Icons.taxi_alert,
            size: 35,
            color: Colors.white,
          ))),
];
