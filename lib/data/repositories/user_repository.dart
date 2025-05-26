import 'package:flutter_application_2/data/database/db.dart';
import 'package:flutter_application_2/domain/models/user.dart';
import 'package:sqflite/sqflite.dart';

abstract class UserRepository {
  Future<User?> getById(int id);
  Future<User?> getByEmail(String email);
  Future<List<User>> getAll();
  Future<User> create(User user);
  Future<User> update(User user);
  Future<bool> delete(int id);
  Future<bool> authenticate(String email, String password);
}

class DatabaseUserRepository implements UserRepository {
  Future<Database> get _db async => await DB.instance.database;

  @override
  Future<User?> getById(int id) async {
    final db = await _db;
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return _fromMap(result.first);
    }
    return null;
  }

  @override
  Future<User?> getByEmail(String email) async {
    final db = await _db;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return _fromMap(result.first);
    }
    return null;
  }

  @override
  Future<List<User>> getAll() async {
    final db = await _db;
    final result = await db.query('users');
    return result.map(_fromMap).toList();
  }

  @override
  Future<User> create(User user) async {
    final db = await _db;
    final id = await db.insert('users', _toMap(user, includeId: false));

    return user.copyWith(id: id);
  }

  @override
  Future<User> update(User user) async {
    final db = await _db;
    if (user.id == null) {
      throw Exception('ID do usuário não pode ser nulo');
    }

    await db.update(
      'users',
      _toMap(user),
      where: 'id = ?',
      whereArgs: [user.id],
    );

    return user;
  }

  @override
  Future<bool> delete(int id) async {
    final db = await _db;
    final rows = await db.delete('users', where: 'id = ?', whereArgs: [id]);

    return rows > 0;
  }

  @override
  Future<bool> authenticate(String email, String password) async {
    final db = await _db;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  User _fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      document: map['document'],
      password: map['password'],
    );
  }

  Map<String, dynamic> _toMap(User user, {bool includeId = true}) {
    final map = <String, dynamic>{
      'name': user.name,
      'email': user.email,
      'document': user.document,
      'password': user.password,
    };

    if (includeId && user.id != null) {
      map['id'] = user.id;
    }

    return map;
  }
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
