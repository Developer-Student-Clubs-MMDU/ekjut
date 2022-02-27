// ignore_for_file: avoid_print

// import 'dart:html';

import 'package:ekjut/api/changing_location.dart';
import 'package:ekjut/api/helps.dart';
import 'package:ekjut/models/services.dart';
import 'package:ekjut/pages/home_pages.dart';
import 'package:ekjut/pages/map.dart';
import 'package:ekjut/pages/register_page.dart';
import 'package:ekjut/wigets/bottomsheet_list.dart';
import 'package:ekjut/wigets/build_circle.dart';
import 'package:ekjut/wigets/build_people.dart';
import 'package:ekjut/wigets/button.dart';
import 'package:ekjut/wigets/circular_icon.dart';
import 'package:ekjut/wigets/help_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:ekjut/wigets/input.dart';
import 'package:ekjut/wigets/multi_choice.dart';
import 'package:ekjut/wigets/red_button.dart';
import 'package:ekjut/wigets/search_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwipeUp = false;
  bool isSwipeRight = false;
  bool isTap = false;
  TextEditingController descriptionController = TextEditingController();
  int i = 0;
  List<String> selectedServicesList = [];
  List<Map<String, dynamic>> serviceList = [];

  selectServices(String service) {
    serviceList = Provider.of<Help>(context, listen: false).getService(service);
  }

  void addHelpToList() {
    latLng.LatLng loc = context.read<ChangeLocation>().helpPosition;
    if (loc == latLng.LatLng(28.6697905, 77.3439278)) {
      // TO DO -- CURRENT POSITION OF DEVICE BY DEFAULT
      loc = latLng.LatLng(28.6697905, 77.3439278);
    }
    context.read<Help>().addHelp({
      'description': descriptionController.text,
      'service': 'Service 1',
      'distance': '100',
      'isSwipUp': false,
      'help': 'xyz',
      'name': 'xyx1',
      'isShow': false,
      'location': loc,
    });
    descriptionController.text = "";
    context.read<ChangeLocation>().afterAddHelp();
  }

  @override
  Widget build(BuildContext context) {
    // TO DO : UPDATE LOCATION OF USER
    context.watch<Help>().updateDistance([0, 0]);

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
                  child: GestureDetector(
                    onTap: () {
                      print("signout");
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 28,
                    ),
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
                child: BuildPeople(id: "Mohit", index: 0),
              ),
              const Positioned(
                top: 390,
                left: 230,
                child: BuildPeople(id: "Sakshi", index: 1),
              ),
              const Positioned(
                top: 300,
                left: 120,
                child: BuildPeople(id: "XYZ", index: 2),
              ),
              const Positioned(
                top: 450,
                left: 100,
                child: BuildPeople(id: "ABC", index: 3),
              ),
              const Positioned(
                top: 500,
                left: 200,
                child: BuildPeople(id: "QWDUI", index: 4),
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
                          padding: const EdgeInsets.all(20.0),
                          decoration: const BoxDecoration(
                            color: Color(0xFF1C173D),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              width: _width * 0.80,
                              height: _height * 0.60,
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
                                  // InputWidget(
                                  //   icon: FontAwesomeIcons.map,
                                  //   label: 'Location',
                                  //   controller: _userLocation,
                                  // ),
                                  const SearchViewInput(),
                                  const SizedBox(
                                    height: 20.0,
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
                                          maxSelection: 1,
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
                                  SingleChildScrollView(
                                    child: TextField(
                                      controller: descriptionController,
                                      style: const TextStyle(
                                          color: Color(0xFFbdc6cf)),
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xFF36306D),
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Enter a description of the help(optional)',
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      // maxLines: 4,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RedButton(
                                          width: _width * 0.3,
                                          label: "Cancel",
                                          onPress: () {
                                            isSwipeRight = false;
                                          },
                                        ),
                                        ButtonWidget(
                                          width: _width * 0.3,
                                          label: "Help",
                                          onPress: () {
                                            isSwipeRight = false;
                                            addHelpToList();
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              AnimatedPositioned(
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 400),
                bottom:
                    isSwipeUp ? 0.0 : (isTap ? -(_height) : -(_height * 0.25)),
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
                                          onPress: () {
                                            print('Inside Service Categories');
                                            i = index;
                                            selectServices(servicesItem[index]);
                                            setState(() {
                                              isSwipeUp = true;
                                              serviceItemSwipUp[index] = true;
                                            });
                                          },
                                        ),
                                      ),
                                      Text(
                                        servicesItem[index],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          isSwipeUp && serviceItemSwipUp[i]
                              ? Expanded(
                                  child: HelpList(
                                    service: servicesItem[i],
                                    serviceList: serviceList,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class SearchViewInput extends StatelessWidget {
  const SearchViewInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SearchView(
          hintText: 'Location',
          wantSuggestions: false,
          indicatorNode: 2,
          isPadding: false),
    );
  }
}
