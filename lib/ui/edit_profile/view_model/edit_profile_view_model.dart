import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';
import 'package:flutter_application_2/domain/models/user.dart';
import 'package:flutter_application_2/ui/shared/session_view_model.dart';

class EditProfileViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final SessionViewModel _sessionViewModel;

  EditProfileViewModel({
    required UserRepository userRepository,
    required SessionViewModel sessionViewModel,
  }) : _userRepository = userRepository,
       _sessionViewModel = sessionViewModel;

  User? get loggedUser => _sessionViewModel.loggedUser;

  Future<void> updateProfile(User updatedUser) async {
    await _userRepository.update(updatedUser);
    _sessionViewModel.setUser(updatedUser);
    notifyListeners();
  }
}
