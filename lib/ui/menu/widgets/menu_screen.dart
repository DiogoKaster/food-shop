import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  //const MenuScreen({super.key, required String nomeRestaurante});
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cardápio'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: const Center(child: Text('Bem-vindo ao Cardápio!')),
    );
  }
}
