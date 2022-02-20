import 'package:flutter/material.dart';

@immutable
class ButtonWidget extends StatelessWidget {
  final String label;
  final Function() onPress;
  final double width;

  const ButtonWidget(
      {Key? key,
      required this.label,
      required this.onPress,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(23),
      color: const Color(0xFF36306D),
      elevation: 5,
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          alignment: Alignment.center,
          // height: height * 0.07,
          width: width,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(26, 41, 128, 100),
                    Color.fromRGBO(42, 178, 252, 100),
                  ]),
              borderRadius: BorderRadius.circular(23)),
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
