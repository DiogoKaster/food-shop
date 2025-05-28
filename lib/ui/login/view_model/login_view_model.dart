import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';
import 'package:flutter_application_2/ui/shared/session_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final SessionViewModel _sessionViewModel;

  bool _isLoading = false;

  LoginViewModel({
    required UserRepository userRepository,
    required SessionViewModel sessionViewModel,
  }) : _userRepository = userRepository,
       _sessionViewModel = sessionViewModel;

  bool get isLoading => _isLoading;

  Future<bool> authenticate(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _userRepository.authenticate(email, password);

    if (result) {
      final user = await _userRepository.getByEmail(email);
      _sessionViewModel.setUser(user);
    }

    _isLoading = false;
    notifyListeners();

    return result;
  }
}
