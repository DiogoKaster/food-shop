import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/shared/session_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final SessionViewModel _sessionViewModel;

  ProfileViewModel({required SessionViewModel sessionViewModel})
    : _sessionViewModel = sessionViewModel {
    _sessionViewModel.addListener(_onSessionChanged);
  }

  get loggedUser => _sessionViewModel.loggedUser;

  void _onSessionChanged() {
    notifyListeners();
  }

  void logout() {
    _sessionViewModel.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _sessionViewModel.removeListener(_onSessionChanged);
    super.dispose();
  }
}
