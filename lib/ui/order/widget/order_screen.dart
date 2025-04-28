import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: const Center(child: Text('Bem-vindo aos Pedidos!')),
    );
  }
}
