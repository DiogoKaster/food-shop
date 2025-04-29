import 'package:flutter_application_2/domain/models/user.dart';

abstract class UserRepository {
  Future<User?> getById(int id);
  Future<User?> getByEmail(String email);
  Future<List<User>> getAll();
  Future<User> create(User user);
  Future<User> update(User user);
  Future<bool> delete(int id);
  Future<bool> authenticate(String email, String password);
}

class InMemoryUserRepository implements UserRepository {
  final List<User> _users = [];
  int _nextId = 1;

  @override
  Future<User?> getById(int id) async {
    return _users.firstWhere((user) => user.id == id);
  }

  @override
  Future<User?> getByEmail(String email) async {
    return _users.firstWhere((user) => user.email == email);
  }

  @override
  Future<List<User>> getAll() async {
    return _users.toList();
  }

  @override
  Future<User> create(User user) async {
    if (_users.any((u) => u.email == user.email)) {
      throw Exception('E-mail já cadastrado');
    }

    final newUser = user.copyWith(id: _nextId++, createdAt: DateTime.now());

    _users.add(newUser);
    return newUser;
  }

  @override
  Future<User> update(User user) async {
    if (user.id == null) {
      throw Exception('ID do usuário não pode ser nulo');
    }

    final index = _users.indexWhere((u) => u.id == user.id);

    if (index == -1) {
      throw Exception('Usuário não encontrado');
    }

    final updatedUser = user.copyWith(updatedAt: DateTime.now());

    _users[index] = updatedUser;
    return updatedUser;
  }

  @override
  Future<bool> delete(int id) async {
    final index = _users.indexWhere((u) => u.id == id);

    if (index == -1) {
      throw Exception('Usuário não encontrado');
    }

    _users.removeAt(index);
    return true;
  }

  @override
  Future<bool> authenticate(String email, String password) async {
    _users.firstWhere(
      (u) =>
          u.email.toLowerCase() == email.toLowerCase() &&
          u.password == password,
    );

    return true;
  }
}
