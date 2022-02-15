import 'package:flutter/material.dart';

@immutable
class RedButton extends StatelessWidget {
  final String label;
  final Function? onPress;
  final double width;

  const RedButton(
      {Key? key,
      required this.label,
      required this.onPress,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress;
      },
      child: Material(
        borderRadius: BorderRadius.circular(23),
        color: const Color(0xFF36306D),
        elevation: 5,
        child: Container(
          alignment: Alignment.center,
          // height: height * 0.07,
          width: width,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(23)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
