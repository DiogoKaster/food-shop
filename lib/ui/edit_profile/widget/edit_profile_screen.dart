import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';
import 'package:flutter_application_2/ui/login/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _cpfController;
  late TextEditingController _passwordController;

  bool _isPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    final user = context.read<LoginViewModel>().loggedUser!;

    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _cpfController = TextEditingController(text: user.document);
    _passwordController = TextEditingController(text: user.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildLabel('Nome'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ú\s]+')),
                ],
                decoration: _inputDecoration(
                  'Digite seu nome completo',
                  Icons.person,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!RegExp(r'^[a-zA-ZÀ-ú\s]+$').hasMatch(value)) {
                    return 'Nome inválido (use apenas letras e espaços)';
                  }
                  if (value.trim().split(' ').length < 2) {
                    return 'Digite seu nome completo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildLabel('Email'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration('Digite seu E-mail', Icons.email),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Formato de e-mail inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildLabel('CPF'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: _inputDecoration(
                  'Digite seu CPF (somente números)',
                  Icons.badge,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (value.length != 11) {
                    return 'CPF deve conter 11 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildLabel('Senha'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: _isPasswordObscured,
                decoration: _inputDecoration(
                  'Digite sua senha',
                  Icons.lock,
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: colorScheme.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (value.length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final viewModel = context.read<LoginViewModel>();
                    final currentUser = viewModel.loggedUser!;
                    final repository = context.read<UserRepository>();

                    // Verificação de e-mail duplicado
                    final existingUser = await repository.getByEmail(
                      _emailController.text,
                    );
                    if (existingUser != null &&
                        existingUser.id != currentUser.id) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Este e-mail já está em uso por outro usuário.',
                          ),
                        ),
                      );
                      return;
                    }

                    final updatedUser = currentUser.copyWith(
                      name: _nameController.text,
                      email: _emailController.text,
                      document: _cpfController.text,
                      password: _passwordController.text,
                    );

                    await viewModel.updateProfile(updatedUser);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Perfil atualizado com sucesso!'),
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.7),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputDecoration(
      filled: true,
      fillColor: colorScheme.surface,
      prefixIcon: Icon(icon),
      prefixIconColor: colorScheme.primary,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[500]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.error, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.error, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 10.0,
      ),
    );
  }
}
