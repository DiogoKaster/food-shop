import 'package:flutter_application_2/domain/models/user_address.dart';

abstract class UserAddressRepository {
  Future<UserAddress?> getById(int id);
  Future<List<UserAddress>> getAllByUserId(int userId);
  Future<UserAddress> create(UserAddress address);
  Future<UserAddress> update(UserAddress address);
  Future<bool> delete(int id);
}

class InMemoryUserAddressRepository implements UserAddressRepository {
  final List<UserAddress> _addresses = [];
  var _nextId = 1;

  @override
  Future<UserAddress?> getById(int id) async {
    return _addresses.firstWhere((a) => a.id == id);
  }

  @override
  Future<List<UserAddress>> getAllByUserId(int userId) async {
    return _addresses.where((a) => a.userId == userId).toList();
  }

  @override
  Future<UserAddress> create(UserAddress address) async {
    final newAddress = UserAddress(
      id: _nextId++,
      userId: address.userId,
      street: address.street,
      number: address.number,
      neighborhood: address.neighborhood,
      city: address.city,
      state: address.state,
      zipCode: address.zipCode,
      complement: address.complement,
      isDefault: address.isDefault,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _addresses.add(newAddress);
    return newAddress;
  }

  @override
  Future<UserAddress> update(UserAddress address) async {
    if (address.id == null) {
      throw Exception('ID do endereço não pode ser nulo');
    }

    final index = _addresses.indexWhere((a) => a.id == address.id);
    if (index == -1) {
      throw Exception('Endereço não encontrado');
    }

    final updatedAddress = address.copyWith(updatedAt: DateTime.now());
    _addresses[index] = updatedAddress;

    return updatedAddress;
  }

  @override
  Future<bool> delete(int id) async {
    final index = _addresses.indexWhere((a) => a.id == id);
    if (index == -1) {
      throw Exception('Endereço não encontrado');
    }

    _addresses.removeAt(index);
    return true;
  }
}
