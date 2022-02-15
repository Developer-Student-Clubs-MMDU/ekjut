import 'package:ekjut/wigets/hero_dialog.dart';
import 'package:flutter/material.dart';
// import '../models/hero_dialog.dart';
// import '../pages/home_page.dart';
// class BuildPeople extends StatelessWidget {
//   //final icon;
//   const BuildPeople({ Key? key ,
//   // required this.icon
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Icon(Icons.person_pin),
//     );
//   }
// }

// class id{
//   final String tag;
//   id({required this.tag});

// }
// List <id> iD=[];

class BuildPeople extends StatefulWidget {
  final double? posH;
  final double? posW;
  final String id;
  const BuildPeople({Key? key, final this.posH, this.posW, required this.id})
      : super(key: key);

  @override
  _BuildPeopleState createState() => _BuildPeopleState();
}

class _BuildPeopleState extends State<BuildPeople> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("tapped");
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Center(
                child: PopUpCard(
              id: widget.id,
            )),
            // builder: (context)=>PopUpCard2(id: widget.id)
          ),
        );
      },
      child: Hero(
        tag: widget.id,
        child: const Icon(
          Icons.person_pin,
          size: 40,
          color: Colors.purple,
        ),
      ),
    );
  }
}

List<BuildPeople> buildpeople = [];

// Widget getPopUpCard(id) {
//     return ;
//   }
class PopUpCard extends StatefulWidget {
  String id;
  PopUpCard({Key? key, required this.id}) : super(key: key);

  @override
  _PopUpCardState createState() => _PopUpCardState();
}

class _PopUpCardState extends State<PopUpCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Hero(
          tag: widget.id,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.red,
            elevation: 10,
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.grey,
              child: Container(
                height: 220,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 20.0,
                          spreadRadius: 4.0),
                    ]),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album, size: 60),
                      title: Text('Person', style: TextStyle(fontSize: 30.0)),
                      subtitle: Text('Bio of Person',
                          style: TextStyle(fontSize: 18.0)),
                    ),
                    ButtonBar(
                      buttonPadding: const EdgeInsets.all(15.0),
                      children: <Widget>[
                        ElevatedButton(
                          child: const Text('Help'),
                          onPressed: () {/* ... */},
                        ),
                        ElevatedButton(
                          child: const Text('Exit'),
                          onPressed: () {
                            Navigator.pop(context);
                            //                     Navigator.push(
                            //                                 context,
                            //                            MaterialPageRoute(builder: (context) => HomePage()),
                            // );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PopUpCard2 extends StatefulWidget {
  String id;
  PopUpCard2({Key? key, required this.id}) : super(key: key);

  @override
  _PopUpCard2State createState() => _PopUpCard2State();
}

class _PopUpCard2State extends State<PopUpCard2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Hero(
      tag: widget.id,
      child: Padding(
        //  padding: const EdgeInsets.all(50),
        padding: EdgeInsets.fromLTRB(20, 300, 20, 300),
        child: Material(
          elevation: 8.0,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            //  elevation: 8.0,
            height: 100,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const ListTile(
                leading: Icon(Icons.album, size: 60),
                title: Text('Person', style: TextStyle(fontSize: 30.0)),
                subtitle:
                    Text('Bio of Person', style: TextStyle(fontSize: 18.0)),
              ),
              ButtonBar(
                buttonPadding: EdgeInsets.all(15.0),
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('Help'),
                    onPressed: () {/* ... */},
                  ),
                  ElevatedButton(
                    child: const Text('Exit'),
                    onPressed: () {
                      //                     Navigator.push(
                      //                                 context,
                      //                            MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                    },
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
