import 'package:flutter/material.dart';
import 'package:flutter_application_2/domain/models/user.dart';

class SessionViewModel extends ChangeNotifier {
  User? _loggedUser;

  User? get loggedUser => _loggedUser;

  void setUser(User? user) {
    _loggedUser = user;
    notifyListeners();
  }

  void clear() {
    _loggedUser = null;
    notifyListeners();
  }
}
