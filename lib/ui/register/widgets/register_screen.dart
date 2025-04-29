/*import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final TextEditingController enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: Text(
          'Cadastro',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: colorScheme.onPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nome',
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: inputDecoration('Digite seu nome', Icons.person),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CPF',
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: inputDecoration('Digite seu CPF', Icons.badge),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: inputDecoration('Digite seu E-mail', Icons.email),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Senha',
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: inputDecoration('Digite sua senha', Icons.lock),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context); //volta para tela de login
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Criar conta',
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: Theme.of(context).colorScheme.onPrimary,
      prefixIcon: Icon(icon),
      prefixIconColor: Theme.of(context).colorScheme.primary,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: Text(
          'Cadastro',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildLabel('Nome', colorScheme),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: inputDecoration(
                  'Digite seu nome completo',
                  Icons.person,
                ),
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ú\s]+')),
                ],
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

              _buildLabel('CPF', colorScheme),
              const SizedBox(height: 8),
              TextFormField(
                controller: _cpfController,
                decoration: inputDecoration(
                  'Digite seu CPF (somente números)',
                  Icons.badge,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
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

              _buildLabel('Email', colorScheme),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: inputDecoration('Digite seu E-mail', Icons.email),
                keyboardType: TextInputType.emailAddress,
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

              _buildLabel('Senha', colorScheme),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: _isPasswordObscured,
                decoration: inputDecoration(
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
                keyboardType: TextInputType.visiblePassword,
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

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String name = _nameController.text;
                      String cpf = _cpfController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      print('Nome: $name');
                      print('CPF: $cpf');
                      print('Email: $email');
                      print('Senha: $password');

                      // TODO: Chamar o ViewModel para criar o usuário
                      // Exemplo:
                      // final viewModel = Provider.of<RegisterViewModel>(context, listen: false);
                      // viewModel.name = name;
                      // viewModel.email = email;
                      // viewModel.document = cpf;
                      // viewModel.password = password;
                      // bool success = await viewModel.createUser();
                      // if (success) {
                      //    Navigator.pop(context); // Volta para a tela anterior em caso de sucesso
                      // } else {
                      //    ScaffoldMessenger.of(context).showSnackBar(
                      //      SnackBar(content: Text(viewModel.errorMessage ?? 'Erro desconhecido')),
                      //    );
                      // }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cadastro iniciado (simulação)'),
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Por favor, corrija os erros no formulário.',
                          ),
                        ),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Criar conta',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, ColorScheme colorScheme) {
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

  InputDecoration inputDecoration(String hint, IconData icon) {
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
