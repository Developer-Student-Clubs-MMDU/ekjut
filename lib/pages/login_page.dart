import 'package:ekjut/wigets/button.dart';
import 'package:ekjut/wigets/circular_icon.dart';
import 'package:ekjut/wigets/input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _emailcontroller = TextEditingController();
    final _passwordcontroller = TextEditingController();

    return Container(
      width: _width,
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(height: 100),
          InputWidget(
            icon: FontAwesomeIcons.userAlt,
            label: "Email",
            controller: _emailcontroller,
          ),
          const SizedBox(height: 50),
          InputWidget(
            icon: FontAwesomeIcons.lock,
            label: "Password",
            controller: _passwordcontroller,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text("Forget Password?",
                    style: TextStyle(
                        color: Colors.grey[400],
                        // fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                        fontSize: 12))),
          ),
          SizedBox(height: _height * 0.1),
          ButtonWidget(
            width: _width * 0.5,
            label: "Login",
            onPress: () {},
          ),
          SizedBox(height: _height * 0.06),
          Row(children: <Widget>[
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                  child: const Divider(
                    color: Colors.white,
                    height: 50,
                  )),
            ),
            const Text("OR", style: TextStyle(color: Colors.white)),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                  child: const Divider(
                    color: Colors.white,
                    height: 50,
                  )),
            ),
          ]),
          SizedBox(height: _height * 0.06),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconWidget(
                color: const Color(0xff39579A),
                icon: FontAwesomeIcons.facebookF,
                onPress: () {},
              ),
              SizedBox(
                width: _width * 0.05,
              ),
              IconWidget(
                color: const Color(0xffDF4A32),
                icon: FontAwesomeIcons.google,
                onPress: () {},
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Don’t have account? ',
                        style: TextStyle(color: Colors.white)),
                    TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
