import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color.fromARGB(255, 28, 98, 119),
      ),
      body: const Center(child: Text('Bem-vindo à Home Page!')),
    );
  }
}
