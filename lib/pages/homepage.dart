// ignore_for_file: avoid_print

import 'package:ekjut/models/services.dart';
import 'package:ekjut/models/services.dart';
import 'package:ekjut/models/services.dart';
import 'package:ekjut/pages/home_pages.dart';
import 'package:ekjut/wigets/bottomsheet_list.dart';
import 'package:ekjut/wigets/build_circle.dart';
import 'package:ekjut/wigets/build_people.dart';
import 'package:ekjut/wigets/button.dart';
import 'package:ekjut/wigets/circular_icon.dart';
import 'package:ekjut/wigets/input.dart';
import 'package:ekjut/wigets/multi_choice.dart';
import 'package:ekjut/wigets/red_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwipeUp = false;
  bool isSwipeRight = false;
  bool isTap = false;
  List<String> selectedServicesList = [];
  @override
  Widget build(BuildContext context) {
    final _userLocation = TextEditingController();

    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF36306D).withOpacity(1),
                  const Color(0xFF1C173D)
                ]),
          ),
          child: GestureDetector(
            onPanEnd: (details) {
              print(details.velocity.pixelsPerSecond.dy);
              print(details.velocity.pixelsPerSecond.dx);
              if (details.velocity.pixelsPerSecond.dy < -100) {
                setState(() {
                  // print("0000000000000");
                  // print(isSwipeUp);

                  isSwipeUp = true;
                  print("0000000000000");
                  print(isSwipeUp);
                });
              } else {
                setState(() {
                  isSwipeUp = false;

                  print("0000000000000");
                  print(isSwipeUp);
                });
              }
            },
            child: Stack(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              fit: StackFit.loose,
              children: [
                Positioned(
                  /// [Menu Button]
                  left: 0.0,
                  top: _height * 0.05,
                  child: Container(
                    height: _height * 0.05,
                    width: _width * 0.17,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            30,
                          ),
                          bottomRight: Radius.circular(30)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromRGBO(26, 41, 128, 100),
                            Color.fromRGBO(42, 178, 252, 90),
                          ]),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),

                IconWidget(
                  onPress: () {},
                  color: const Color(0xFF1C173D),
                  icon: FontAwesomeIcons.userAlt,
                  size: 20.0,
                ),

                //1
                BuildCircle(opacity: 0.7, radius: _width * 0.35),
                //2
                BuildCircle(opacity: 0.6, radius: _width * 0.55),
                //3
                BuildCircle(opacity: 0.5, radius: _width * 0.80),
                //4
                BuildCircle(opacity: 0.3, radius: _width * 1.5),

                const Positioned(
                  top: 200,
                  left: 200,
                  child: BuildPeople(id: "Mohit"),
                ),
                const Positioned(
                  top: 390,
                  left: 230,
                  child: BuildPeople(id: "Sakshi"),
                ),
                const Positioned(
                  top: 300,
                  left: 120,
                  child: BuildPeople(id: "Gopi bhau"),
                ),
                const Positioned(
                  top: 450,
                  left: 100,
                  child: BuildPeople(id: "chota haluman"),
                ),
                const Positioned(
                  top: 500,
                  left: 200,
                  child: BuildPeople(id: "sakshi2"),
                ),
                AnimatedPositioned(
                  curve: Curves.decelerate,
                  top: _height * 0.1,
                  right: isSwipeRight
                      ? _width * 0.075
                      : -((_width * 0.80) - (_width * 0.01)),
                  duration: const Duration(milliseconds: 400),
                  child: GestureDetector(
                      onPanEnd: (details) {
                        print(details.velocity.pixelsPerSecond.dx.toString());
                        if (details.velocity.pixelsPerSecond.dx < -150) {
                          setState(() {
                            isSwipeRight = true;
                          });
                        } else if (details.velocity.pixelsPerSecond.dx > 150) {
                          setState(() {
                            isSwipeRight = false;
                          });
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _width * 0.03,
                            height: _height * 0.15,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors:
                                      // (isSwipeRight) ?
                                      //  [Color(0xFF1C173D)] :
                                      [
                                    Color.fromRGBO(40, 154, 231, 100),
                                    Color.fromRGBO(26, 94, 132, 100),
                                  ]),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                          Container(
                            width: _width * 0.80,
                            height: _height * 0.60,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1C173D),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Help",
                                        style: TextStyle(
                                            color: Colors.white,
                                            // fontFamily: "Roboto",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSwipeRight = false;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  InputWidget(
                                    icon: FontAwesomeIcons.map,
                                    label: 'Location',
                                    controller: _userLocation,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Services:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            // fontFamily: "Roboto",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: false,
                                      children: [
                                        MultiSelectChip(
                                          servicesItem,
                                          onSelectionChanged: (selectedList) {
                                            setState(() {
                                              selectedServicesList =
                                                  selectedList;
                                              // print(selectedMonthList);
                                            });
                                          },
                                          maxSelection: 7,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Description:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            // fontFamily: "Roboto",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  const TextField(
                                    style: TextStyle(color: Color(0xFFbdc6cf)),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF36306D),
                                      border: OutlineInputBorder(),
                                      hintText:
                                          'Enter a description of the help(optional)',
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RedButton(
                                          width: _width * 0.3,
                                          label: "Canel",
                                          onPress: () {
                                            isSwipeRight = false;
                                          },
                                        ),
                                        ButtonWidget(
                                          width: _width * 0.3,
                                          label: "Help",
                                          onPress: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                AnimatedPositioned(
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 400),
                  bottom: isSwipeUp
                      ? 0.0
                      : (isTap ? -(_height) : -(_height * 0.25)),
                  child: GestureDetector(
                    onPanEnd: (details) {
                      print(details.velocity.pixelsPerSecond.dy.toString());
                      print(details.velocity.pixelsPerSecond.dx.toString());
                      if (details.velocity.pixelsPerSecond.dy < -100) {
                        setState(() {
                          isSwipeUp = true;
                        });
                      } else {
                        setState(() {
                          isSwipeUp = false;
                        });
                      }
                    },
                    child: Container(
                      height: _height * 0.45,
                      width: _width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xFF1A2980),
                          Color(0xFF2AB2FC),
                        ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Search to help",
                                  style: TextStyle(
                                      color: Colors.white,
                                      // fontFamily: "Roboto",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                (isSwipeUp)
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSwipeUp = false;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.expand_more_outlined,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSwipeUp = true;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.expand_less_outlined,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      )
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: servicesItem.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IconWidget(
                                            color: Colors.red,
                                            icon: Icons.food_bank,
                                            onPress: () {},
                                          ),
                                        ),
                                        Text(
                                          servicesItem[index],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
