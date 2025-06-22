/*import 'package:flutter/material.dart';
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
}*/

/*import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  final SessionViewModel _sessionViewModel;

  File? _profileImage;
  File? get profileImage => _profileImage;

  ProfileViewModel({required SessionViewModel sessionViewModel})
    : _sessionViewModel = sessionViewModel {
    _sessionViewModel.addListener(_onSessionChanged);
    _loadProfileImage();
  }

  get loggedUser => _sessionViewModel.loggedUser;

  void _onSessionChanged() {
    notifyListeners();
  }

  Future<void> logout() async {
    _sessionViewModel.clear();
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final savedImage = await File(
        pickedFile.path,
      ).copy('${directory.path}/profile_image.jpg');

      _profileImage = savedImage;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', savedImage.path);
      notifyListeners();
    }
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image_path');

    if (path != null && File(path).existsSync()) {
      _profileImage = File(path);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _sessionViewModel.removeListener(_onSessionChanged);
    super.dispose();
  }
}*/

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_2/domain/models/user.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';
import 'package:flutter_application_2/ui/shared/session_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final SessionViewModel _sessionViewModel;
  final UserRepository _userRepository;

  File? _profileImage;
  File? get profileImage => _profileImage;

  ProfileViewModel({
    required SessionViewModel sessionViewModel,
    required UserRepository userRepository,
  }) : _sessionViewModel = sessionViewModel,
       _userRepository = userRepository {
    _sessionViewModel.addListener(_onSessionChanged);
    _loadProfileImage();
  }

  User? get loggedUser => _sessionViewModel.loggedUser;

  void _onSessionChanged() {
    _loadProfileImage();
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null && loggedUser != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_user_${loggedUser!.id}.jpg';

      final savedImage = await File(pickedFile.path).copy(imagePath);
      _profileImage = savedImage;

      final updatedUser = loggedUser!.copyWith(profileImage: savedImage.path);

      await _userRepository.update(updatedUser);
      _sessionViewModel.setUser(updatedUser);
      await _loadProfileImage();
      notifyListeners();
    }
  }

  Future<void> _loadProfileImage() async {
    final user = loggedUser;
    if (user?.profileImage != null && File(user!.profileImage!).existsSync()) {
      _profileImage = File(user.profileImage!);
    } else {
      _profileImage = null;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _sessionViewModel.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _sessionViewModel.removeListener(_onSessionChanged);
    super.dispose();
  }
}
