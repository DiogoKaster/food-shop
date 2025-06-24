import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';
import 'package:flutter_application_2/ui/shared/session_view_model.dart';
import 'package:http/http.dart' as http;

class ManageAddressViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final SessionViewModel _sessionViewModel;

  String? cep;
  String? street;
  String? number;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;

  bool isLoading = false;
  String? errorMessage;

  ManageAddressViewModel({
    required UserRepository userRepository,
    required SessionViewModel sessionViewModel,
  }) : _userRepository = userRepository,
       _sessionViewModel = sessionViewModel;

  Future<void> loadAddressFromUser() async {
    final user = _sessionViewModel.loggedUser;
    if (user == null) {
      errorMessage = 'Usuário não logado para carregar endereço.';
      notifyListeners();
      return;
    }

    try {
      final updatedUser = await _userRepository.getById(user.id!);
      if (updatedUser != null) {
        cep = updatedUser.cep;
        street = updatedUser.street;
        number = updatedUser.number;
        complement = updatedUser.complement;
        neighborhood = updatedUser.neighborhood;
        city = updatedUser.city;
        state = updatedUser.state;
      }
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Erro ao carregar endereço: $e';
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchAddressByCep(String inputCep) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final sanitizedCep = inputCep.replaceAll(RegExp(r'[^0-9]'), '');

    if (sanitizedCep.length != 8) {
      errorMessage = 'CEP inválido. Deve conter 8 dígitos.';
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://viacep.com.br/ws/$sanitizedCep/json/'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data.containsKey('erro') && data['erro'] == true) {
          errorMessage = 'CEP não encontrado.';
        } else {
          street = data['logradouro'];
          neighborhood = data['bairro'];
          city = data['localidade'];
          state = data['uf'];
          cep = data['cep'];
          errorMessage = null;
        }
      } else {
        errorMessage = 'Erro ao buscar endereço: ${response.statusCode}.';
      }
    } catch (e) {
      errorMessage = 'Erro de conexão ou formato de CEP inválido: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateCep(String value) {
    cep = value;
    notifyListeners();
  }

  void updateStreet(String value) {
    street = value;
    notifyListeners();
  }

  void updateNumber(String value) {
    number = value;
    notifyListeners();
  }

  void updateComplement(String value) {
    complement = value;
    notifyListeners();
  }

  void updateNeighborhood(String value) {
    neighborhood = value;
    notifyListeners();
  }

  void updateCity(String value) {
    city = value;
    notifyListeners();
  }

  void updateState(String value) {
    state = value;
    notifyListeners();
  }

  Future<bool> saveAddress() async {
    errorMessage = null;
    notifyListeners();

    final user = _sessionViewModel.loggedUser;
    if (user == null) {
      errorMessage = 'Usuário não está logado.';
      notifyListeners();
      return false;
    }

    if (street == null ||
        street!.isEmpty ||
        number == null ||
        number!.isEmpty ||
        neighborhood == null ||
        neighborhood!.isEmpty ||
        city == null ||
        city!.isEmpty ||
        state == null ||
        state!.isEmpty ||
        cep == null ||
        cep!.isEmpty) {
      errorMessage =
          'Por favor, preencha todos os campos obrigatórios do endereço.';
      notifyListeners();
      return false;
    }

    try {
      final updatedUser = user.copyWith(
        cep: cep,
        street: street,
        number: number,
        complement: complement,
        neighborhood: neighborhood,
        city: city,
        state: state,
        updatedAt: DateTime.now(),
      );

      await _userRepository.update(updatedUser);
      return true;
    } catch (e) {
      errorMessage = 'Erro ao salvar endereço: $e';
      notifyListeners();
      return false;
    }
  }
}
