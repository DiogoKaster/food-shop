import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/login/widgets/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
