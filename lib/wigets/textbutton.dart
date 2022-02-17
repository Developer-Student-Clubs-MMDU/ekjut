import 'package:flutter/material.dart';

textButton(title, Color color1, Color color2, Function onPress,
        {required double height, required double width}) =>
    Material(
      // shape: CircleBorder(side: BorderSide.none),
      borderRadius: BorderRadius.circular(23),
      color: const Color(0xFF36306D),
      elevation: 5,
      child: Container(
        alignment: Alignment.center,
        height: height * 0.07,
        width: width * 0.3,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [color1, color2]),
            borderRadius: BorderRadius.circular(23)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
