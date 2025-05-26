import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/cart/widget/cart_screen.dart';
import 'package:flutter_application_2/ui/login/widgets/login_screen.dart';
import 'package:flutter_application_2/ui/home/widgets/home_screen.dart';
import 'package:flutter_application_2/ui/menu/widgets/menu_screen.dart';
import 'package:flutter_application_2/ui/order/widget/order_screen.dart';
import 'package:flutter_application_2/ui/profile/widget/profile_screen.dart';
import 'package:flutter_application_2/ui/register/widgets/register_screen.dart';
import 'package:flutter_application_2/ui/search/widget/search_screen.dart';
import 'package:flutter_application_2/ui/principal/widget/principal_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const register = 'register';
  static const home = '/home';
  static const menu = '/menu';
  static const cart = '/cart';
  static const profile = '/profile';
  static const order = '/order';
  static const orderDetails = '/order_details';
  static const search = '/search';
  static const principal = '/principal';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      home: (context) => const HomeScreen(),
      menu:
          (context) =>
              const MenuScreen(restauranteName: '', restauranteImage: ''),
      cart: (context) => const CartScreen(),
      profile: (context) => const ProfileScreen(),
      order: (context) => const OrderScreen(),
      search: (context) => const SearchScreen(),
      principal: (context) => const PrincipalScreen(),
    };
  }
}
