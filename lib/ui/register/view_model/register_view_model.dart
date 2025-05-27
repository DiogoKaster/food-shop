/*import 'package:flutter/material.dart';
import 'package:flutter_application_2/domain/models/user.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  String name = '';
  String email = '';
  String document = '';
  String password = '';
  String? errorMessage;
  bool isLoading = false;

  RegisterViewModel({required this.userRepository});

  Future<bool> createUser() async {
    notifyListeners();

    try {
      final user = User(
        name: name,
        email: email,
        document: document,
        password: password,
      );
      await userRepository.create(user);
      errorMessage = null;
      return true;
    } catch (e) {
      errorMessage = 'Erro ao criar usuário';
      return false;
    } finally {
      notifyListeners();
    }
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_application_2/domain/models/user.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  String name = '';
  String email = '';
  String document = '';
  String password = '';
  String? errorMessage;
  bool isLoading = false;

  RegisterViewModel({required this.userRepository});

  Future<bool> createUser() async {
    isLoading = true;
    notifyListeners();

    try {
      final existingUser = await userRepository.getByEmail(email);
      if (existingUser != null) {
        errorMessage = 'E-mail já cadastrado';
        return false;
      }

      final user = User(
        name: name,
        email: email,
        document: document,
        password: password,
      );

      await userRepository.create(user);
      errorMessage = null;
      return true;
    } catch (e) {
      errorMessage = 'Erro ao criar usuário';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
