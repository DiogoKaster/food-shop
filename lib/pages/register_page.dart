import 'package:flutter/material.dart';
import 'package:flutter_application_2/dialog/endereco_dialog.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 98, 119),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 98, 119),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('Cadastro', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Nome', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: inputDecoration('Digite seu nome', Icons.person),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('CPF', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: inputDecoration('Digite seu CPF', Icons.badge),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Endereço', style: TextStyle(color: Colors.white)),
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
              child: Text('Email', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: inputDecoration('Digite seu E-mail', Icons.email),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Senha', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: inputDecoration('Digite sua senha', Icons.lock),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //TODO: Validação
                  Navigator.pop(context); //volta para tela de login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Criar conta',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 31, 123, 139),
                  ),
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
      fillColor: Colors.white,
      prefixIcon: Icon(icon, color: const Color.fromARGB(255, 31, 123, 139)),
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
