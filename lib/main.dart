import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/app.dart';
import 'package:flutter_application_2/data/repositories/restaurant_repository.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';
import 'package:flutter_application_2/ui/home/view_model/home_view_model.dart';
import 'package:flutter_application_2/ui/login/view_model/login_view_model.dart';
import 'package:flutter_application_2/ui/register/view_model/register_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<UserRepository>(create: (context) => DatabaseUserRepository()),
        Provider<RestaurantRepository>(
          create: (context) => DatabaseRestaurantRepository(),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create:
              (context) => HomeViewModel(
                restaurantRepository: context.read<RestaurantRepository>(),
              ),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create:
              (context) => LoginViewModel(
                userRepository: context.read<UserRepository>(),
              ),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create:
              (context) => RegisterViewModel(
                userRepository: context.read<UserRepository>(),
              ),
        ),
      ],
      child: App(),
    ),
  );
}
