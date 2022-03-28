// ignore_for_file: use_key_in_widget_constructors

import 'package:ekjut/pages/map.dart';
import 'package:flutter/material.dart';

class HelpList extends StatefulWidget {
  final String service;
  final List<Map<String, dynamic>> serviceList;
  const HelpList({required this.service, required this.serviceList});

  @override
  State<HelpList> createState() => _HelpListState();
}

class _HelpListState extends State<HelpList> {
  @override

  // context.watch<Help>().getService(service);
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.serviceList.length,
      itemBuilder: (context, int index) {
        return widget.serviceList[index]['isShow']
            ? InkWell(
                onTap: () {
                  // widget.serviceList[index]['isShow'] = false;
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MapsPage(
                  //         index: index,
                  //         personLocation: widget.serviceList[index]
                  //             ["location"]),
                  //   ),
                  // );
                  // moveCamera(
                  //     widget.serviceList[index][
                  //         'location'],
                  //     index);
                  // Navigator.pop(
                  //     context);
                },
                child: Container(
                  color: const Color.fromRGBO(196, 196, 196, 0.2),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.serviceList[index]['isShow'] = false;
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Name :${widget.serviceList[index]['name']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Distance :${widget.serviceList[index]['distance']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Help :${widget.serviceList[index]['help']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Description :${widget.serviceList[index]['description']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : ListTile(
                onLongPress: () {
                  print('pressed');
                  // deleteHelp(index);
                },
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Distance : ${widget.serviceList[index]['distance']} m',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      ' Help : ${widget.serviceList[index]['help']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                // title:
                trailing: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.serviceList[index]['isShow'] = true;
                    });
                  },
                  child: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ),
              );
      },
    );
  }
}
