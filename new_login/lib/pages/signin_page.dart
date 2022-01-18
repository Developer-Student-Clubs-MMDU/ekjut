import 'package:flutter/material.dart';
import 'package:new_login/pages/home_page.dart';
import './login_page.dart';
import '../models/list.dart';
import '../widgets/multi_dropdown.dart';
class signup extends StatefulWidget {

  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          SizedBox(
            height: h * 0.1,
          ),
          TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                hintText: "Name",
                hintStyle: const TextStyle(color: Colors.white),
                // enabledBorder: const OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(12)),
                //   borderSide: BorderSide(
                //       width: 3, color: Colors.black),
                // ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  //  borderSide:  BorderSide(color: Colors.pink, width: 5),
                ),
                filled: true,
                fillColor: const Color(0xFF1C173D),
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.white,
                )),
          ),
          SizedBox(
            height: h * 0.06,
          ),
          TextField(
            controller: signinEmailWordController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                hintText: "Mail",
                hintStyle: const TextStyle(color: Colors.white),
                // enabledBorder: const OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(12)),
                //   borderSide: BorderSide(
                //       width: 3, color: Colors.black),
                // ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  //  borderSide:  BorderSide(color: Colors.pink, width: 5),
                ),
                filled: true,
                fillColor: const Color(0xFF1C173D),
                prefixIcon: const Icon(
                  Icons.mail_outline,
                  color: Colors.white,
                )),
          ),
          SizedBox(
            height: h * 0.06,
          ),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                hintText: "Location",
                hintStyle: const TextStyle(color: Colors.white),
                // enabledBorder: const OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(12)),
                //   borderSide: BorderSide(
                //       width: 3, color: Colors.black),
                // ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  //  borderSide:  BorderSide(color: Colors.pink, width: 5),
                ),
                filled: true,
                fillColor: const Color(0xFF1C173D),
                prefixIcon: const Icon(
                  Icons.gps_fixed,
                  color: Colors.white,
                )),
          ),
          SizedBox(
            height: h * 0.06,
          ),
          //          TextField(
          // style: const  TextStyle(color: Colors.white),
          //       decoration: InputDecoration(
          //                   contentPadding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
          //                         hintText: "Services",
          //                         hintStyle:const  TextStyle(color: Colors.white),
          //                        // enabledBorder: const OutlineInputBorder(
          //                         //   borderRadius: BorderRadius.all(Radius.circular(12)),
          //                         //   borderSide: BorderSide(
          //                         //       width: 3, color: Colors.black),
          //                         // ),
          //                         border:  OutlineInputBorder(
          //                           borderRadius: BorderRadius.circular(8.0),
          //                         //  borderSide:  BorderSide(color: Colors.pink, width: 5),
          //                         ),
          //                        filled: true,
          //                        fillColor: const Color(0xFF1C173D),
          //                        suffixIcon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,)
          //            ),
          //            ),

          Container(
            height: h * 0.1,
            width: w * 0.8,
            decoration: BoxDecoration(
                color: const Color(0xFF1C173D),
                borderRadius: BorderRadius.circular(8.0)),
            child: InkWell(
                onTap: multiSelect,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Services',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    )
                  ],
                )),
          ),
          SizedBox(
            height: h * 0.06,
          ),
          // if(selectedServicesItem!=null)Wrap(
          // children: selectedServicesItem
          //     .map((e) => Chip(
          //           label: Text(e),
          //         ))
          //     .toList()),

          if (selectedServicesItem != null)
            Material(
              elevation: 2.0,
              color: Colors.black12,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedServicesItem.length,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      title: Text(selectedServicesItem[index]),
                      trailing: InkWell(
                          onTap: () {
                            removeServices(index);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                      textColor: Colors.white,
                    );
                  }),
            ),
          SizedBox(
            height: h * 0.06,
          ),

          InkWell(
            onTap: (){Navigator.push(
              context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child:textButton('Sign Up'))
        ],
      ),
    ));
  }

  void multiSelect() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: servicesItem);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        selectedServicesItem = results;
      });
    }
  }

  void removeServices(int index) {
    setState(() {
      selectedServicesItem.remove(selectedServicesItem[index]);
    });
  }
}