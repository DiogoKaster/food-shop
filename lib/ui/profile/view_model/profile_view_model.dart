import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/shared/session_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final SessionViewModel _sessionViewModel;

  ProfileViewModel({required SessionViewModel sessionViewModel})
    : _sessionViewModel = sessionViewModel;

  get loggedUser => _sessionViewModel.loggedUser;

  void logout() {
    _sessionViewModel.clear();
    notifyListeners();
  }
}
