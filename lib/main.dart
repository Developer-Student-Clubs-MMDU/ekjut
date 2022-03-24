import 'package:ekjut/api/helps.dart';
import 'package:ekjut/api/user_details.dart';
import 'package:ekjut/pages/verify_email_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ekjut/api/changing_location.dart';
import 'package:ekjut/api/location_api.dart';
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
      ChangeNotifierProvider(create: (_) => UserDetails()),
      ChangeNotifierProvider(create: (_) => LocationApi()),
      ChangeNotifierProvider(create: (_) => ChangeLocation()),
      ChangeNotifierProvider(create: (_) => Help())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              context.watch<UserDetails>().updateUid(currentUser.uid);
              print("00000000000000000${currentUser.uid}");
            }

            return snapshot.hasData
                ? const VerifyEmailPage()
                : const RegistrationPage();
          }),
    );
  }
}
