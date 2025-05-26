import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/app.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<UserRepository>(create: (context) => DatabaseUserRepository()),
      ],
      child: App(),
    ),
  );
}
