import 'package:flutter/material.dart';
import 'package:flutter_application_2/routing/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: colorScheme.primary),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: colorScheme.primary),
                hintText: 'Digite seu E-mail',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Senha',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: colorScheme.primary),
                hintText: 'Digite sua senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Entrar'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Criar conta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
