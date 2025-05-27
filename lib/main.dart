import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/app.dart';
import 'package:flutter_application_2/data/repositories/product_respository.dart';
import 'package:flutter_application_2/data/repositories/restaurant_repository.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';
import 'package:flutter_application_2/ui/edit_profile/view_model/edit_profile_view_model.dart';
import 'package:flutter_application_2/ui/home/view_model/home_view_model.dart';
import 'package:flutter_application_2/ui/login/view_model/login_view_model.dart';
import 'package:flutter_application_2/ui/menu/view_model/menu_view_model.dart';
import 'package:flutter_application_2/ui/profile/view_model/profile_view_model.dart';
import 'package:flutter_application_2/ui/register/view_model/register_view_model.dart';
import 'package:flutter_application_2/ui/shared/session_view_model.dart';
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
        ChangeNotifierProvider(create: (context) => SessionViewModel()),
        ChangeNotifierProvider(
          create:
              (context) => LoginViewModel(
                userRepository: DatabaseUserRepository(),
                sessionViewModel: context.read<SessionViewModel>(),
              ),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create:
              (context) => RegisterViewModel(
                userRepository: context.read<UserRepository>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => ProfileViewModel(
                sessionViewModel: context.read<SessionViewModel>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => EditProfileViewModel(
                userRepository: DatabaseUserRepository(),
                sessionViewModel: context.read<SessionViewModel>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  MenuViewModel(productRepository: DatabaseProductRepository()),
        ),
      ],
      child: App(),
    ),
  );
}
