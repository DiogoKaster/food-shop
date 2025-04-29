import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/login/widgets/login_screen.dart';
import 'package:flutter_application_2/ui/home/widgets/home_screen.dart';
import 'package:flutter_application_2/ui/menu/widgets/menu_screen.dart';
import 'package:flutter_application_2/ui/register/widgets/register_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const register = 'register';
  static const home = '/home';
  static const menu = '/menu';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginScreen(),
      register: (context) => RegisterScreen(),
      home: (context) => HomeScreen(),
      menu: (context) => MenuScreen(restauranteName: '', restauranteImage: ''),
    };
  }
}
