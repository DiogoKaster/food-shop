/*import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  bool _isLoading = false;

  LoginViewModel({required UserRepository userRepository})
    : _userRepository = userRepository;

  bool get isLoading => _isLoading;

  Future<bool> authenticate(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _userRepository.authenticate(email, password);

    _isLoading = false;
    notifyListeners();

    return result;
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';
import 'package:flutter_application_2/domain/models/user.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  bool _isLoading = false;
  User? _loggedUser;

  LoginViewModel({required UserRepository userRepository})
    : _userRepository = userRepository;

  bool get isLoading => _isLoading;
  User? get loggedUser => _loggedUser;

  Future<bool> authenticate(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _userRepository.authenticate(email, password);

    if (result) {
      _loggedUser = await _userRepository.getByEmail(email);
    }

    _isLoading = false;
    notifyListeners();

    return result;
  }

  void logout() {
    _loggedUser = null;
    notifyListeners();
  }

  Future<void> updateProfile(User updatedUser) async {
    await _userRepository.update(updatedUser);
    _loggedUser = updatedUser;
    notifyListeners();
  }
}
