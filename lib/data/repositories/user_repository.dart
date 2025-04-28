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
  // final List<User> _users = [];
  // final int _nextId = 1;

  @override
  Future<User?> getById(int id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<User?> getByEmail(String email) {
    // TODO: implement getUserByEmail
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAll() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<User> create(User user) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<User> update(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<bool> authenticate(String email, String password) {
    // TODO: implement authenticateUser
    throw UnimplementedError();
  }
}
