import 'package:flutter/material.dart';

class UserDetails extends ChangeNotifier {
  String _uid = "";
  String get uid => _uid;
  void updateUid(uid) {
    _uid = uid;
    // notifyListeners();
  }
}
