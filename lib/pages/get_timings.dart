import 'package:ekjut/api/changing_location.dart';
import 'package:ekjut/pages/make_profile_page.dart';
import 'package:ekjut/pages/register_page.dart';
import 'package:ekjut/pages/signup_page.dart';
import 'package:ekjut/wigets/button.dart';
import 'package:ekjut/wigets/multi_choice.dart';
import 'package:ekjut/wigets/red_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';

class GetMyTimings extends StatefulWidget {
  const GetMyTimings({Key? key}) : super(key: key);

  @override
  _GetMyTimingsState createState() => _GetMyTimingsState();
}

class _GetMyTimingsState extends State<GetMyTimings> {
  List<String> selectedMonthList = [];
  static List<String> monthList = ["Mon", "Tue", "Wed", "Thr", "Fri", "Sat"];

  // final DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const GetMyLocation()));
                },
                child: Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: const Color(0xFF1C173D),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.map,
                          size: 18,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 14),
                        Text(
                          context.watch<ChangeLocation>().source,
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SelectTimings(width: _width, height: _height),
              MultiSelectChip(
                monthList,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    selectedMonthList = selectedList;
                    // print(selectedMonthList);
                  });
                },
                maxSelection: 7,
              ),
              const SizedBox(height: 14),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "Select the path:",
              //         style: TextStyle(
              //             color: Colors.grey[400],
              //             fontFamily: "Roboto",
              //             fontWeight: FontWeight.w700,
              //             fontSize: 12),
              //       ),
              //       Icon(
              //         FontAwesomeIcons.infoCircle,
              //         size: 18,
              //         color: Colors.grey[400],
              //       ),
              //     ],
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (context) => const GetMyLocation()));
              //   },
              //   child: Container(
              //     height: 60,
              //     width: double.maxFinite,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(6.0),
              //       color: const Color(0xFF1C173D),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.25),
              //           spreadRadius: 0,
              //           blurRadius: 4,
              //           offset: const Offset(0, 4),
              //         ),
              //       ],
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Row(
              //         children: [
              //           Icon(
              //             FontAwesomeIcons.map,
              //             size: 18,
              //             color: Colors.grey[400],
              //           ),
              //           const SizedBox(width: 14),
              //           Text(
              //             context.watch<ChangeLocation>().source,
              //             style: TextStyle(
              //                 color: Colors.grey[400],
              //                 fontFamily: "Roboto",
              //                 fontWeight: FontWeight.w700,
              //                 fontSize: 12),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const GetMyLocation()));
                },
                child: Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: const Color(0xFF1C173D),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.map,
                          size: 18,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 14),
                        Text(
                          context.watch<ChangeLocation>().destination,
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SelectTimings(width: _width, height: _height),
              MultiSelectChip(
                monthList,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    selectedMonthList = selectedList;
                    // print(selectedMonthList);
                  });
                },
                maxSelection: 7,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RedButton(
                    width: _width * 0.4,
                    label: "Cancel",
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  ButtonWidget(
                    width: _width * 0.4,
                    label: "Save",
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const MakeProfile(),
                        ),
                      );
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class SelectTimings extends StatelessWidget {
  const SelectTimings({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly, // use whichever suits your need

      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("From:",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(
              width: _width * 0.4,
              height: _height * 0.2,
              // color: Colors.green,
              child: Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (value) {
                    // if (value != null && value != selectedDate)
                    //   setState(() {
                    //     selectedDate = value;

                    //   });
                  },
                  initialDateTime: DateTime.now(),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("To:",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(
              width: _width * 0.4,
              height: _height * 0.2,
              // color: Colors.green,
              child: Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (value) {
                    // if (value != null && value != selectedDate)
                    //   setState(() {
                    //     selectedDate = value;

                    //   });
                  },
                  initialDateTime: DateTime.now(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
