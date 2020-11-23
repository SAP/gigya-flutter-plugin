import 'package:flutter/material.dart';

class SessionStateProvider with ChangeNotifier {
  bool loggedIn = false;

  void updateLoginState(state) {
    loggedIn = state;
    notifyListeners();
  }
}
