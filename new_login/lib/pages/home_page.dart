import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/bottomsheet_list.dart';
import 'package:new_login/pages/login_page.dart';
import '../widgets/build_circle.dart';
import '../size_config.dart';
import '../models/buildpeople.dart';
import 'dart:math';
bool isSwipeUp = false;
// Size wsize = Size.zero;
String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

double height = 0.0;
double width = 0.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double randnum(n) {
    Random rand = new Random();
    double randNum = rand.nextDouble() * n;

    return randNum;
  }

  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    height = SizeConfig.screenHeight!;
    width = SizeConfig.screenWidth!;
    return SafeArea(
      child: Scaffold(
        ///appBar: AppBar(elevation: 0,),
        backgroundColor: primaryColor,
        body: Container(
          width: width,
          height: height,
          color: primaryColor,
          child: GestureDetector(
            onPanEnd: (details){
                            print(details.velocity.pixelsPerSecond.dy.toString());
                            print(details.velocity.pixelsPerSecond.dx.toString());
                          if(details.velocity.pixelsPerSecond.dy<-100){
                            setState(() {
                              isSwipeUp = true;
                            });
                            
                          }
                          else{
                            setState(() {
                              isSwipeUp = false;
                            });
                          }
                        },

                    //  onVerticalDragEnd: (details){
                    //    print(details.velocity.pixelsPerSecond.dy);
                    //    print(details.velocity.pixelsPerSecond.dx);

                    //  },   

            child: Stack(
              //  alignment: AlignmentDirectional.center,
              // ignore: deprecated_member_use
              // overflow: Overflow.clip,
              //clipBehavior: Clip.hardEdge,
              children: [
                // Center(child: getCon(height, width)),
          
                Positioned(
                  /// [Menu Button]
                  left: 0.0,
                  top: height * 0.05,
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.2,
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
                      size: 40,
                    ),
                  ),
                ),
                Positioned(
                  top: (height * 0.15),
                  right: -width * 0.15,
                  child: BuildCircle(
                      color: const Color.fromRGBO(42, 178, 252, 90),
                      radius: width * 1.3),
                ),
                Positioned(
                  top: (height * 0.23),
                  right: width * 0.025,
                  child: BuildCircle(
                      color: const Color.fromRGBO(42, 178, 252, 90),
                      radius: width * 0.95),
                ),
                Positioned(
                  top: (height * 0.30),
                  right: width * 0.175,
                  child: BuildCircle(
                      color: const Color.fromRGBO(42, 178, 252, 90),
                      radius: width * 0.65),
                ),
                Positioned(
                  top: (height * 0.359),
                  right: width * 0.3,
                  child: BuildCircle(
                      color: const Color.fromRGBO(42, 178, 252, 90),
                      radius: width * 0.4),
                ),
                Positioned(
                  top: height * 0.39,
                  left: width * 0.36,
                  child: const Material(
                    shape: CircleBorder(),
                    elevation: 8.0,
                    child: CircleAvatar(
                        radius: 48,
                        backgroundImage:
                            AssetImage("assets/images/randomPic_OfGuy.png")),
                  ),
                ),
          
                //  const Positioned(
                //    top: 0.0,
          
                //    child: ButtonSheetSwpieUp()),
                // Positioned(
                //   bottom: 0.0,
                //   child: ButtonSheetSwpieUp()),
          
                for (final itr in buildpeople)
                  Positioned(
                    top: itr.posW,
                    left: itr.posH,
                    child: itr,
                  ),
          
                  AnimatedOpacity(
                    duration: const  Duration(milliseconds: 400),
                    opacity: (isSwipeUp)?1.0:0.0,
                  child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
          
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),),
                  ),
          
                AnimatedPositioned(
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 400),
                  bottom: isSwipeUp?0.0:-(height*0.25),
                    child: GestureDetector(

                      ///This method was not [smooth]
                        // onPanUpdate: (details) {
                        //   if (details.delta.dx > 0) {
                        //     setState(() {
                        //       isSwipeUp = true;
                        //     });
                        //   } else {
                        //     setState(() {
                        //       isSwipeUp = false;
                        //     });
                        //   }
                        // },
                        onPanEnd: (details){
                            print(details.velocity.pixelsPerSecond.dy.toString());
                            print(details.velocity.pixelsPerSecond.dx.toString());
                          if(details.velocity.pixelsPerSecond.dy<-100){
                            setState(() {
                              isSwipeUp = true;
                            });
                            
                          }
                          else{
                            setState(() {
                              isSwipeUp = false;
                            });
                          }
                        },
                        child: ButtonSheetSwpieUp()))
              ],
            ),
          ),
        ),
        //   ),
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // print(w);
            // print(h);
            double w1 = randnum(width - 20);
            double h1 = randnum(width - 20);
            String randstr = generateRandomString(15);
            setState(() {
              buildpeople.add(BuildPeople(
                posW: w1,
                posH: h1,
                id: randstr,
              ));
              // iD.add(id(tag:randstr));
            });
            print(w1);
            print(h1);
            print(buildpeople.length);
            // print(wsize.width.toString());
            // print(wsize.height.toString());
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      ),
    );
  }
}

class ButtonSheetSwpieUp extends StatefulWidget {
  const ButtonSheetSwpieUp({Key? key}) : super(key: key);

  @override
  State<ButtonSheetSwpieUp> createState() => _ButtonSheetSwpieUpState();
}

class _ButtonSheetSwpieUpState extends State<ButtonSheetSwpieUp> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height * 0.5,
      width: width,
      // color: Colors.white,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(26, 41, 128, 100),
                  Color.fromRGBO(42, 178, 252, 100),
        ]),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
        ),
    
      // duration: const Duration(milliseconds: 400),
      // transform: Matrix4.translationValues(0, 0, 0)
      // ..scale(0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [(isSwipeUp)?Icon(Icons.expand_more_outlined,size: 30,color: Colors.white,):
              Icon(Icons.expand_less_outlined,size: 30,color: Colors.white,)
              ],),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: listBottomSheet.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: isSwipeUp? const EdgeInsets.all(8.0): const EdgeInsets.only(left: 10,right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          listBottomSheet[index].widget,
                          Text(
                            listBottomSheet[index].name,
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              height: isSwipeUp? height*0.25:height*0.25,
              width: width,
              child: ListView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 25,
                          width: 20,
                           color: const  Color(0xFF1C173D) ,
                          // color: Colors.pink,
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 4000),
      width: width,
      height: height * 0.4,
      decoration: const BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), topLeft: Radius.circular(50))),
    );
  }
}






