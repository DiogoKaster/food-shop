import 'package:flutter/material.dart';

class EnderecoDialog extends StatelessWidget {
  final Function(String) onEnderecoPreenchido;

  EnderecoDialog({super.key, required this.onEnderecoPreenchido});

  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Endereço Completo'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: logradouroController,
              decoration: InputDecoration(labelText: 'Logradouro'),
            ),
            TextField(
              controller: numeroController,
              decoration: InputDecoration(labelText: 'Número'),
            ),
            TextField(
              controller: bairroController,
              decoration: InputDecoration(labelText: 'Bairro'),
            ),
            TextField(
              controller: cidadeController,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: estadoController,
              decoration: InputDecoration(labelText: 'Estado'),
            ),
            TextField(
              controller: cepController,
              decoration: InputDecoration(labelText: 'CEP'),
            ),
            TextField(
              controller: complementoController,
              decoration: InputDecoration(labelText: 'Complemento'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: Text('Salvar'),
          onPressed: () {
            String enderecoCompleto =
                '${logradouroController.text}, ${numeroController.text}, ${bairroController.text}, '
                '${cidadeController.text}, ${estadoController.text}, CEP: ${cepController.text} ${complementoController.text}';
            onEnderecoPreenchido(enderecoCompleto);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
