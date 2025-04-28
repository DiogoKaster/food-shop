import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/register/widgets/address_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final TextEditingController enderecoController = TextEditingController();

  void abrirPopupEndereco() {
    showDialog(
      context: context,
      builder: (context) {
        return EnderecoDialog(
          onEnderecoPreenchido: (String enderecoCompleto) {
            setState(() {
              enderecoController.text = enderecoCompleto;
            });
          },
        );
      },
    );
  }

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
                'Endereço',
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: abrirPopupEndereco,
              child: AbsorbPointer(
                child: TextField(
                  controller: enderecoController,
                  decoration: inputDecoration(
                    'Digite seu Endereço',
                    Icons.home,
                  ),
                ),
              ),
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
                  //TODO: Validação
                  Navigator.pop(context); //volta para tela de login
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
}
