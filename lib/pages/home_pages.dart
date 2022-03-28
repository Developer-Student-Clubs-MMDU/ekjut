// // ignore_for_file: avoid_print

// import 'package:ekjut/models/size_config.dart';
// import 'package:ekjut/wigets/bottomsheet_list.dart';
// import 'package:ekjut/wigets/build_circle.dart';
// import 'package:ekjut/wigets/build_people.dart';
// import 'package:ekjut/wigets/textbutton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// // import '../models/bottomsheet_list.dart';
// // import 'package:new_login/pages/login_page.dart';
// // import '../widgets/build_circle.dart';
// // import '../size_config.dart';
// // import '../models/buildpeople.dart';
// import 'dart:math';

// bool isSwipeUp = false;
// bool isSwipeRight = false;
// bool isTap = false;
// // Size wsize = Size.zero;
// String generateRandomString(int len) {
//   var r = Random();
//   const _chars =
//       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//   return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
// }

// double height = 0.0;
// double width = 0.0;

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   double randnum(n) {
//     Random rand = Random();
//     double randNum = rand.nextDouble() * n;

//     return randNum;
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     height = SizeConfig.screenHeight!;
//     width = SizeConfig.screenWidth!;
//     return SafeArea(
//       child: Scaffold(
//         ///appBar: AppBar(elevation: 0,),
//         backgroundColor: const Color(0xFF36306D),
//         body: Container(
//           width: width,
//           height: height,
//           color: const Color(0xFF36306D),
//           child: GestureDetector(
//             onPanEnd: (details) {
//               print(details.velocity.pixelsPerSecond.dy.toString());
//               print(details.velocity.pixelsPerSecond.dx.toString());
//               if (details.velocity.pixelsPerSecond.dy < -100) {
//                 setState(() {
//                   isSwipeUp = true;
//                 });
//               } else {
//                 setState(() {
//                   isSwipeUp = false;
//                 });
//               }
//             },

//             //  onVerticalDragEnd: (details){
//             //    print(details.velocity.pixelsPerSecond.dy);
//             //    print(details.velocity.pixelsPerSecond.dx);

//             //  },

//             child: Stack(
//               //  alignment: AlignmentDirectional.center,
//               // ignore: deprecated_member_use
//               // overflow: Overflow.clip,
//               //clipBehavior: Clip.hardEdge,
//               children: [
//                 // Center(child: getCon(height, width)),

//                 // Positioned(
//                 //   /// [Menu Button]
//                 //   left: 0.0,
//                 //   top: height * 0.05,
//                 //   child: Container(
//                 //     height: height * 0.07,
//                 //     width: width * 0.2,
//                 //     decoration: const BoxDecoration(
//                 //       borderRadius: BorderRadius.only(
//                 //           topRight: Radius.circular(
//                 //             30,
//                 //           ),
//                 //           bottomRight: Radius.circular(30)),
//                 //       gradient: LinearGradient(
//                 //           begin: Alignment.centerLeft,
//                 //           end: Alignment.centerRight,
//                 //           colors: [
//                 //             Color.fromRGBO(26, 41, 128, 100),
//                 //             Color.fromRGBO(42, 178, 252, 90),
//                 //           ]),
//                 //     ),
//                 //     alignment: Alignment.center,
//                 //     child: const Icon(
//                 //       Icons.menu,
//                 //       color: Colors.white,
//                 //       size: 40,
//                 //     ),
//                 //   ),
//                 // ),
//                 // Positioned(
//                 //   top: (height * 0.15),
//                 //   right: -width * 0.15,
//                 //   child: BuildCircle(
//                 //       color: const Color.fromRGBO(42, 178, 252, 90),
//                 //       radius: width * 1.3),
//                 // ),
//                 // Positioned(
//                 //   top: (height * 0.23),
//                 //   right: width * 0.025,
//                 //   child: BuildCircle(
//                 //       color: const Color.fromRGBO(42, 178, 252, 90),
//                 //       radius: width * 0.95),
//                 // ),
//                 // Positioned(
//                 //   top: (height * 0.30),
//                 //   right: width * 0.175,
//                 //   child: BuildCircle(
//                 //       color: const Color.fromRGBO(42, 178, 252, 90),
//                 //       radius: width * 0.65),
//                 // ),
//                 // Positioned(
//                 //   top: (height * 0.359),
//                 //   right: width * 0.3,
//                 //   child: BuildCircle(
//                 //       color: const Color.fromRGBO(42, 178, 252, 90),
//                 //       radius: width * 0.4),
//                 // ),
//                 // Positioned(
//                 //   top: height * 0.39,
//                 //   left: width * 0.36,
//                 //   child: const Material(
//                 //     shape: CircleBorder(),
//                 //     elevation: 8.0,
//                 //     child: CircleAvatar(
//                 //       backgroundColor: Colors.blue,
//                 //       radius: 48,
//                 //       // backgroundImage:
//                 //       //     AssetImage("assets/images/randomPic_OfGuy.png")
//                 //     ),
//                 //   ),
//                 // ),

//                 //  const Positioned(
//                 //    top: 0.0,

//                 //    child: ButtonSheetSwpieUp()),
//                 // Positioned(
//                 //   bottom: 0.0,
//                 //   child: ButtonSheetSwpieUp()),

//                 for (final itr in buildpeople)
//                   Positioned(
//                     top: itr.posW,
//                     left: itr.posH,
//                     child: itr,
//                   ),

//                 // AnimatedOpacity(
//                 //   duration: const  Duration(milliseconds: 400),
//                 //   opacity: (isSwipeUp)?1.0:0.0,
//                 // child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),

//                 //   child: Container(
//                 //     color: Colors.black.withOpacity(0.2),
//                 //   ),),
//                 // ),
//                 AnimatedPositioned(
//                   curve: Curves.decelerate,
//                   top: height * 0.15,
//                   right: isSwipeRight ? width * 0.075 : -(width * 0.85) * 0.85,
//                   duration: Duration(milliseconds: 400),
//                   child: GestureDetector(
//                     onPanEnd: (details) {
//                       print(details.velocity.pixelsPerSecond.dx.toString());
//                       if (details.velocity.pixelsPerSecond.dx < -150) {
//                         setState(() {
//                           isSwipeRight = true;
//                         });
//                       } else if (details.velocity.pixelsPerSecond.dx > 150) {
//                         setState(() {
//                           isSwipeRight = false;
//                         });
//                       }
//                     },
//                     child: Container(
//                       height: height * 0.5,
//                       width: width * 0.85,
//                       // color: Colors.black,
//                       child: Stack(children: [
//                         Positioned(
//                           left: (width * 0.85) * 0.0333,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 // color: isSwipeRight ? Color.fromRGBO(28, 23, 61, 100) : Colors.blue,
//                                 color: const Color(0xff1C173D),
//                                 gradient: isSwipeRight
//                                     ? null
//                                     : const LinearGradient(
//                                         begin: Alignment.centerLeft,
//                                         end: Alignment.centerRight,
//                                         colors: [
//                                             Color.fromRGBO(40, 154, 231, 100),
//                                             Color.fromRGBO(26, 94, 132, 100),
//                                           ]),
//                                 borderRadius: BorderRadius.circular(20)),
//                             width: width * 0.65,
//                             height: (height * 0.5) * 0.35,
//                             child: const Text(" "),
//                           ),
//                         ),
//                         Positioned(
//                           top: (height * 0.5) * 0.05,
//                           left: (width * 0.85) * 0.01,
//                           child: Material(
//                             elevation: isSwipeRight ? 10.0 : 0.0,
//                             // shadowColor: null,
//                             borderRadius: BorderRadius.circular(20),
//                             child: InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   isSwipeRight = !isSwipeRight;
//                                 });
//                               },
//                               child: AnimatedContainer(
//                                 curve: Curves.decelerate,
//                                 duration: Duration(milliseconds: 400),
//                                 decoration: BoxDecoration(
//                                   // color: Colors.red,
//                                   color: const Color(0xff1C173D),
//                                   shape: BoxShape.circle,
//                                   border:
//                                       Border.all(width: 3, color: Colors.blue),
//                                 ),
//                                 child: isSwipeRight
//                                     ? const Icon(
//                                         Icons.arrow_forward_ios_rounded,
//                                         color: Colors.white,
//                                       )
//                                     : const Icon(
//                                         Icons.arrow_back_ios_rounded,
//                                         color: Colors.white,
//                                       ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                             left: (width * 0.85) * 0.15,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: isSwipeRight
//                                       ? const Color(0xff1C173D)
//                                       : Colors.blue,
//                                   borderRadius: BorderRadius.circular(20)),
//                               width: width * 0.7222,
//                               height: (height * 0.5),
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: (height * 0.5) * 0.0266,
//                                   ),
//                                   Row(
//                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(width: (width * 0.85) * 0.05),
//                                       const Text(
//                                         "Help",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 19,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(width: (width * 0.85) * 0.55),
//                                       InkWell(
//                                           onTap: () {
//                                             setState(() {
//                                               isSwipeRight = false;
//                                             });
//                                           },
//                                           child: const Icon(
//                                             Icons.close,
//                                             color: Colors.white,
//                                           ))
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: (height * 0.5) * 0.05,
//                                   ),
//                                   Container(
//                                     height: (height * 0.5) * 0.15,
//                                     width: (width * 0.85) * 0.8,
//                                     decoration: BoxDecoration(
//                                         gradient: const LinearGradient(
//                                             begin: Alignment.bottomCenter,
//                                             end: Alignment.topCenter,
//                                             colors: [
//                                               Color.fromRGBO(26, 41, 128, 100),
//                                               Color.fromRGBO(42, 178, 252, 100),
//                                             ]),
//                                         borderRadius:
//                                             BorderRadius.circular(8.0)),
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           /// height:  ((height * 0.5)*0.15)*0.1,
//                                           width: ((width * 0.85) * 0.8) * 0.2,
//                                           child: const Icon(
//                                             Icons.gps_fixed_outlined,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         const Text(
//                                           "Location",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w400),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: (height * 0.5) * 0.05,
//                                   ),
//                                   const Padding(
//                                     padding:
//                                         const EdgeInsets.only(left: 10, top: 5),
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text("Services",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.normal)),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: (height * 0.5) * 0.15,
//                                     width: width * 0.85,
//                                     child: ListView.builder(
//                                         scrollDirection: Axis.horizontal,
//                                         shrinkWrap: true,
//                                         itemCount: listBottomSheet.length,
//                                         itemBuilder: (context, index) {
//                                           //  return Padding(
//                                           //    padding: const EdgeInsets.only(right: 15,top: 8),
//                                           //    child: listBottomSheet[index].widget,
//                                           //  );
//                                           return Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Container(
//                                               height: (height * 0.5) * 0.15,
//                                               width: (width * 0.85) * 0.35,
//                                               alignment: Alignment.center,
//                                               decoration: const BoxDecoration(
//                                                   gradient: LinearGradient(
//                                                       begin:
//                                                           Alignment.centerLeft,
//                                                       end:
//                                                           Alignment.centerRight,
//                                                       colors: [
//                                                         Color.fromRGBO(
//                                                             26, 41, 128, 100),
//                                                         Color.fromRGBO(
//                                                             42, 178, 252, 100),
//                                                       ]),
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(20))),
//                                               child: Text(
//                                                 listBottomSheet[index].name,
//                                                 style: const TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                             ),
//                                           );
//                                         }),
//                                   ),
//                                   SizedBox(
//                                     height: (height * 0.5) * 0.0111,
//                                   ),
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         width: (width * 0.7222) * 0.04,
//                                       ),
//                                       const Text(
//                                         "Description",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: SizedBox(
//                                       height: (height * 0.5) * 0.18,
//                                       child: SingleChildScrollView(
//                                         child: FocusScope(
//                                           child: Focus(
//                                             onFocusChange: (focus) {
//                                               setState(() {
//                                                 isTap = focus;
//                                               });
//                                             },
//                                             child: TextField(
//                                               onTap: () {
//                                                 setState(() {
//                                                   isTap = true;
//                                                 });
//                                               },
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                               keyboardType:
//                                                   TextInputType.multiline,
//                                               maxLines: null,
//                                               decoration: InputDecoration(
//                                                 focusedBorder: InputBorder.none,
//                                                 contentPadding:
//                                                     const EdgeInsets.fromLTRB(
//                                                         20.0, 20.0, 20.0, 20.0),
//                                                 hintText: "Write Description",
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 14,
//                                                     color: Colors.white),
//                                                 border: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           8.0),
//                                                   // borderSide:  BorderSide(color: Colors.teal, width: 5),
//                                                 ),
//                                                 filled: true,
//                                                 fillColor: Color(0xFF393464),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: (height * 0.5) * 0.01,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       // textButton("Cancel", Colors.red,height:height,width:width,
//                                       //     Colors.redAccent, () {}),
//                                       // textButton(
//                                       //     "Help",
//                                       //      Color.fromRGBO(26, 41, 128, 100),
//                                       //     Color.fromRGBO(42, 178, 252, 100),
//                                       //     () {})
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ))
//                       ]),
//                     ),
//                   ),
//                 ),

//                 AnimatedPositioned(
//                     curve: Curves.decelerate,
//                     duration: const Duration(milliseconds: 400),
//                     bottom: isSwipeUp
//                         ? 0.0
//                         : isTap
//                             ? -(height)
//                             : -(height * 0.25),
//                     child: GestureDetector(

//                         ///This method was not [smooth]
//                         // onPanUpdate: (details) {
//                         //   if (details.delta.dx > 0) {
//                         //     setState(() {
//                         //       isSwipeUp = true;
//                         //     });
//                         //   } else {
//                         //     setState(() {
//                         //       isSwipeUp = false;
//                         //     });
//                         //   }
//                         // },
//                         onPanEnd: (details) {
//                           print(details.velocity.pixelsPerSecond.dy.toString());
//                           print(details.velocity.pixelsPerSecond.dx.toString());
//                           if (details.velocity.pixelsPerSecond.dy < -100) {
//                             setState(() {
//                               isSwipeUp = true;
//                             });
//                           } else {
//                             setState(() {
//                               isSwipeUp = false;
//                             });
//                           }
//                         },
//                         child: ButtonSheetSwpieUp()))
//               ],
//             ),
//           ),
//         ),
//         //   ),
//         // ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // print(w);
//             // print(h);
//             double w1 = randnum(width - 20);
//             double h1 = randnum(width - 20);
//             String randstr = generateRandomString(15);
//             setState(() {
//               buildpeople.add(BuildPeople(
//                 posW: w1,
//                 posH: h1,
//                 id: randstr,
//                 index:0,
//               ));
//               // iD.add(id(tag:randstr));
//             });
//             print(w1);
//             print(h1);
//             print(buildpeople.length);
//             // print(wsize.width.toString());
//             // print(wsize.height.toString());
//           },
//           child: const Icon(Icons.add),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
//       ),
//     );
//   }
// }

// class ButtonSheetSwpieUp extends StatefulWidget {
//   const ButtonSheetSwpieUp({Key? key}) : super(key: key);

//   @override
//   State<ButtonSheetSwpieUp> createState() => _ButtonSheetSwpieUpState();
// }

// class _ButtonSheetSwpieUpState extends State<ButtonSheetSwpieUp> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height * 0.5,
//       width: width,
//       // color: Colors.white,
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(colors: [
//             Color.fromRGBO(26, 41, 128, 100),
//             Color.fromRGBO(42, 178, 252, 100),
//           ]),
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(50), topRight: Radius.circular(50))),

//       // duration: const Duration(milliseconds: 400),
//       // transform: Matrix4.translationValues(0, 0, 0)
//       // ..scale(0),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 (isSwipeUp)
//                     ? Icon(
//                         Icons.expand_more_outlined,
//                         size: 30,
//                         color: Colors.white,
//                       )
//                     : Icon(
//                         Icons.expand_less_outlined,
//                         size: 30,
//                         color: Colors.white,
//                       )
//               ],
//             ),
//             Expanded(
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemCount: listBottomSheet.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: isSwipeUp
//                           ? const EdgeInsets.all(8.0)
//                           : const EdgeInsets.only(left: 10, right: 15),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         // crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           listBottomSheet[index].widget,
//                           Text(
//                             listBottomSheet[index].name,
//                             style: const TextStyle(color: Colors.white),
//                           )
//                         ],
//                       ),
//                     );
//                   }),
//             ),
//             Container(
//               height: isSwipeUp ? height * 0.25 : height * 0.25,
//               width: width,
//               child: ListView.builder(
//                   itemCount: 8,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) => Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Container(
//                           height: 25,
//                           width: 20,
//                           color: const Color(0xFF1C173D),
//                           // color: Colors.pink,
//                         ),
//                       )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Demo extends StatelessWidget {
//   const Demo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 4000),
//       width: width,
//       height: height * 0.4,
//       decoration: const BoxDecoration(
//           color: Colors.yellow,
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(50), topLeft: Radius.circular(50))),
//     );
//   }
// }
