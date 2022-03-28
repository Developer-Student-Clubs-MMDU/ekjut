import 'package:flutter/material.dart';

@immutable
class IconWidget extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final Color color;
  final double? size;
  const IconWidget({
    Key? key,
    required this.onPress,
    required this.icon,
    required this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            icon,
            size: size,
            color: Colors.white,
          )), //
    );
  }
}
