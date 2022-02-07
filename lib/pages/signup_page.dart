import 'package:ekjut/wigets/button.dart';
import 'package:ekjut/wigets/input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _emailcontroller = TextEditingController();
    final _namedcontroller = TextEditingController();
    final _locationdcontroller = TextEditingController();
    final _servivecontroller = TextEditingController();

    return Container(
      width: _width,
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(height: 100),
          InputWidget(
            icon: FontAwesomeIcons.userAlt,
            label: "Name",
            controller: _namedcontroller,
          ),
          const SizedBox(height: 30),
          InputWidget(
            icon: FontAwesomeIcons.inbox,
            label: "Email",
            controller: _emailcontroller,
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {},
            child: InputWidget(
              icon: FontAwesomeIcons.map,
              label: "Location",
              controller: _locationdcontroller,
            ),
          ),
          const SizedBox(height: 30),
          InputWidget(
            icon: FontAwesomeIcons.handsHelping,
            label: "Services",
            controller: _servivecontroller,
          ),
          const SizedBox(height: 40),
          ButtonWidget(
            width: _width * 0.5,
            label: "Sign up",
            onPress: () {},
          ),
        ],
      ),
    );
  }
}
