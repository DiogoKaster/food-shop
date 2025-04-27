import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
