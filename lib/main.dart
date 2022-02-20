// ignore_for_file: unused_import

import 'package:ekjut/api/helps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ekjut/api/changing_location.dart';
import 'package:ekjut/api/location_api.dart';
import 'package:ekjut/pages/homepage.dart';
import 'package:ekjut/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SdkContext.init(IsolateOrigin.main);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LocationApi()),
      ChangeNotifierProvider(create: (_) => ChangeLocation()),
      ChangeNotifierProvider(create: (_) => Help())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      // home: const MyHomePage(),
    );
  }
}


//main