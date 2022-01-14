// import 'package:dotted_border/dotted_border.dart';
//import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:new_login/pages/login_page.dart';
// import '../style.dart';
import '../widgets/build_circle.dart';
// import 'package:measured_size/measured_size.dart';
import '../size_config.dart';
import '../models/buildpeople.dart';
import 'dart:math';
// Size wsize = Size.zero;
String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}
double height=0.0;
double width = 0.0 ;
class HomePage  extends StatefulWidget {
  const HomePage ({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double  randnum(n){
    Random rand = new Random();
    double randNum = rand.nextDouble()*n;
    
   return randNum ;
}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
     height =SizeConfig.screenHeight!;
     width = SizeConfig.screenWidth!;
    return SafeArea(
      child: Scaffold(
        
         //appBar: AppBar(elevation: 0,),
         backgroundColor: primaryColor,
        // body: Center(
        //   child: Container(
        //     height: width-15,
        //     width: width-15,
        //     color: Colors.black12,
           
            body: Container(
              width: width,
              height: height,
              color: primaryColor,
              child: Stack(
              //  alignment: AlignmentDirectional.center,
               // ignore: deprecated_member_use
              //  overflow: Overflow.clip,
                //clipBehavior: Clip.hardEdge,
                children: [
                  
                  // Center(child: getCon(height, width)),

                  Positioned(     /// [Menu Button]
                    left: 0.0,
                    top: height*0.05,
                    child: Container(
                      height: height*0.07,
                      width: width*0.2,
                      decoration:const BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30,),bottomRight: Radius.circular(30)),
                        gradient: LinearGradient(
                       
                       begin: Alignment.centerLeft,end: Alignment.centerRight, colors: [
                        Color.fromRGBO(26, 41, 128, 100),
                          Color.fromRGBO(42, 178, 252, 90),
                        ]),
                        ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.menu,color: Colors.white,size: 40,),
                    ),
                  ),
                   Positioned(
                   top: (height*0.15),
                   right: -width*0.15,
                  child: BuildCircle(color: const Color.fromRGBO(42, 178, 252, 90), radius:width*1.3),),
                   Positioned(
                   top: (height*0.23),
                   right: width*0.025,
                  child: BuildCircle(color: const Color.fromRGBO(42, 178, 252, 90), radius:width*0.95),),
                   Positioned(
                   top: (height*0.30),
                   right: width*0.175,
                  child: BuildCircle(color: const Color.fromRGBO(42, 178, 252, 90), radius:width*0.65),),
                   Positioned(
                   top: (height*0.359),
                   right: width*0.3,
                  child: BuildCircle(color: const Color.fromRGBO(42, 178, 252, 90), radius:width*0.4),),
                  Positioned(
                    top: height*0.39,
                    left: width*0.36,
                    child: const Material(
                      shape: CircleBorder(),
                      elevation: 8.0,
                      child:  CircleAvatar(
                        radius: 48,
                        backgroundImage: AssetImage("assets/images/randomPic_OfGuy.png")),
                    ),
                    ),
                  
                    
                    for(final itr in buildpeople)
                     Positioned(top: itr.posW,
                     left: itr.posH,
                       child: itr,),
                   
    
                ],
              ),
            ),
        //   ),
        // ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          // print(w);
          // print(h);
         double w1 = randnum(width-20);
         double h1 =randnum(width-20);
         String randstr = generateRandomString(15);
          setState(() {
            buildpeople.add(BuildPeople(posW: w1,posH: h1,id: randstr,));
            // iD.add(id(tag:randstr));
          });
          print(w1);
          print(h1);
          print(buildpeople.length);
          // print(wsize.width.toString());
          // print(wsize.height.toString());
          
        },
        child: const Icon(
          Icons.add
        ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    
    
      ),
    );
  }
}






/// [List.builder] && [List.seperator] was used to generate list of people in our stack widgets 
                // Positioned.fill(
                //                  child: ListView.separated(
                //                   //    physics: ClampingScrollPhysics(),
                //                   //  scrollDirection: Axis.horizontal,
                //                    //shrinkWrap: true,
                //                    separatorBuilder: (context ,index)=>Divider(
                //                      color: Colors.black,
                //                    ),
                //                    itemCount: buildpeople.length,
                //                    itemBuilder: ( context , index)=>Container(
                //                      child: buildpeople[index]
                //                    ),
                //                  ),
                // ),








// Widget getpeople(){
  
//   return Positioned(child: Container(),);
// }




// [ 
//   child: DottedBorder(
//             padding: EdgeInsets.all(50),
//             child: Container(
//               clipBehavior: Clip.none,
//              width: w*0.5,
//               height: h*0.25,
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
//                color: Colors.brown,),
             
//       ),
//             borderType: BorderType.Circle,
//             strokeWidth: 4,
//             radius: Radius.circular(50),
            
//             color: Colors.red,
//             dashPattern: [25,10,25,10],
//           ),
//           ]


