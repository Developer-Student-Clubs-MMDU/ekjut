import 'package:flutter/material.dart';

class BuildCircle extends StatelessWidget {
  final  double radius;
  
  final Color color;

  const BuildCircle({ Key? key,
  required this.color,
  required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
              width: radius,
              decoration: BoxDecoration(
            //shape: BoxShape.circle,
            border: Border.all(width: 3, color: color),
            borderRadius: BorderRadius.circular(radius),
            // color: color
          ),
      
    );
  }
}
Widget getCon (h,w){
  return InkWell(
    onTap: (){print('tapped');},
    child: Container(height: w-10,width: w-10,
    // color: Colors.brown,
    child: Stack(
      children: [Positioned(
                // top: ((h*0.5)-((w-120)/2))-5,
                // left: ((w*0.5-((w-120)/2))),
                  top:  (((w-10)*0.5)-((w-120)/2))-5,
                  left: (((w-10)*0.5-((w-120)/2))),                
                // width: w*50,
                child: BuildCircle(color: Colors.red, radius: w-120 ),),
              Positioned(
                // top: ((h*0.5)-((w-220)/2))-5,
                // left: ((w*0.5-((w-220)/2))),
                top:  (((w-10)*0.5)-((w-220)/2))-5,
                left: (((w-10)*0.5-((w-220)/2))),


                child: BuildCircle(color: Colors.green,radius: w-220,),
              ),
              Positioned(
                // top: ((h*0.5)-((w-320)/2))-5,
                // left: ((w*0.5-((w-320)/2))),
                top: (((w-10)*0.5)-((w-320)/2))-5,
                left: (((w-10)*0.5-((w-320)/2))),
                child: BuildCircle(radius: w-320,color: Colors.pink,),),
                Positioned(
                top: (((w-10)*0.5)-((w-20)/2)),
                left: (((w-10)*0.5-((w-20)/2))),
                child: BuildCircle(color: Colors.blueAccent, radius:w-20),
                             
                              ),
                              ],
    ),
      ),
  );
}

List <Widget> pos(h,w) => [

];