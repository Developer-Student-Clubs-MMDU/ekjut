import 'package:flutter/material.dart';

@immutable
class InputWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  // Icon treling;
  final TextEditingController controller;

  const InputWidget(
      {Key? key,
      required this.icon,
      required this.label,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          hintText: label,
          hintStyle: TextStyle(
              color: Colors.grey[400],
              fontFamily: "Roboto",
              fontWeight: FontWeight.w700,
              fontSize: 12),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(6.0),
          ),
          filled: true,
          fillColor: const Color(0xFF1C173D),
          prefixIcon: Icon(
            icon,
            size: 18,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
