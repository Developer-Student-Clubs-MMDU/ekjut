// ignore_for_file: avoid_print

import 'package:ekjut/api/changing_location.dart';
import 'package:ekjut/api/location_api.dart';
import 'package:ekjut/wigets/place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchView extends StatefulWidget {
  bool wantSuggestions;
  String hintText;
  int indicatorNode;
  bool? isPadding;
  SearchView(
      {Key? key,
      required this.wantSuggestions,
      required this.hintText,
      required this.indicatorNode,
      this.isPadding})
      : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _scrollController = ScrollController();
  bool containerSuggestions = false;
  String value = '';
  @override
  Widget build(BuildContext context) {
    String getText() {
      if (widget.indicatorNode == 0 &&
          context.read<ChangeLocation>().source != '') {
        return context.read<ChangeLocation>().source;
      } else if (widget.indicatorNode == 1 &&
          context.read<ChangeLocation>().destination != '') {
        return context.read<ChangeLocation>().destination;
      } else if (widget.indicatorNode == 2 &&
          context.read<ChangeLocation>().helpPos != '') {
        return context.read<ChangeLocation>().helpPos;
      }
      return "";
    }

    print('build ...');
    print(widget.wantSuggestions);

    return SingleChildScrollView(
      child: SearchInjector(
        child: Consumer2<LocationApi, ChangeLocation>(
          builder: (_, api, locationValue, child) => SingleChildScrollView(
            child: Container(
              padding: widget.isPadding == false
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
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
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(6.0),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black.withOpacity(0.25),
                    //       spreadRadius: 0,
                    //       blurRadius: 4,
                    //       offset: const Offset(0, 4),
                    //     ),
                    //   ],
                    // ),
                    // width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          widget.wantSuggestions = true;
                          containerSuggestions = true;
                          print(widget.wantSuggestions);
                        });
                      },
                      controller: api.addressController,
                      onChanged: (value) {
                        api.handleSearch(value);
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: getText() == "" ? widget.hintText : getText(),
                        // hintText: widget.hintText,
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.wantSuggestions,
                    child: Container(
                      color: Colors.blue[100]!.withOpacity(0.3),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: StreamBuilder<List<Place>>(
                        stream: api.controllerOut,
                        builder: (context, snapshot) {
                          print('Inside Builder');
                          print(widget.wantSuggestions);
                          if (snapshot.data == null) {
                            return const Center(
                                child: Text('No Address Found'));
                          }
                          final data = snapshot.data;
                          return Scrollbar(
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Container(
                                child: Builder(
                                  builder: (context) {
                                    return Column(
                                        children: List.generate(
                                      data!.length,
                                      (index) {
                                        final place = data[index];
                                        return ListTile(
                                          onTap: () {
                                            if (widget.indicatorNode == 0) {
                                              // changing source at profile page
                                              context
                                                  .read<ChangeLocation>()
                                                  .sourceLocation(
                                                      '${place.name}, ${place.street}, ${place.country}');
                                              // changing source location at home page
                                              context
                                                  .read<ChangeLocation>()
                                                  .sourceLocationPosition(
                                                      '${place.name}, ${place.street}, ${place.country}');
                                            }
                                            if (widget.indicatorNode == 1) {
                                              print('destination is triggred');
                                              context
                                                  .read<ChangeLocation>()
                                                  .destinationLocation(
                                                      '${place.name}, ${place.street}, ${place.country}');

                                              context
                                                  .read<ChangeLocation>()
                                                  .destinationLocationPosition(
                                                      '${place.name}, ${place.street}, ${place.country}');
                                            }
                                            if (widget.indicatorNode == 2) {
                                              context
                                                  .read<ChangeLocation>()
                                                  .helpLocation(
                                                      '${place.name}, ${place.street}, ${place.country}');

                                              context
                                                  .read<ChangeLocation>()
                                                  .helpLocationPosition(
                                                      '${place.name}, ${place.street}, ${place.country}');
                                              widget.wantSuggestions = false;
                                            }

                                            api.addressController.text =
                                                '${place.name}, ${place.street}, ${place.country}';
                                          },
                                          title: Text(
                                              '${place.name}, ${place.street}'),
                                          subtitle: Text('${place.country}'),
                                        );
                                      },
                                    ));
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class SearchInjector extends StatelessWidget {
//   final Widget child;
//   const SearchInjector({required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider<LocationApi>(create: (context) => LocationApi()),
//         ChangeNotifierProvider<ChangeLocation>(create: (context) => ChangeLocation()),
//       ],
//       child: child,
//     );
//   }
// }

class SearchInjector extends StatelessWidget {
  final Widget child;
  const SearchInjector({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationApi(),
      child: child,
    );
  }
}
