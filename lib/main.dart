import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/app.dart';
import 'package:flutter_application_2/data/repositories/order_item_repository.dart';
import 'package:flutter_application_2/data/repositories/order_repository.dart';
import 'package:flutter_application_2/data/repositories/product_respository.dart';
import 'package:flutter_application_2/data/repositories/restaurant_repository.dart';
import 'package:flutter_application_2/data/repositories/user_repository.dart';
import 'package:flutter_application_2/data/services/cart_service.dart';
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
        Provider<UserRepository>(create: (_) => DatabaseUserRepository()),
        Provider<RestaurantRepository>(
          create: (_) => DatabaseRestaurantRepository(),
        ),
        Provider<ProductRepository>(create: (_) => DatabaseProductRepository()),
        Provider<OrderRepository>(create: (_) => DatabaseOrderRepository()),
        Provider<OrderItemRepository>(
          create: (_) => DatabaseOrderItemRepository(),
        ),

        ChangeNotifierProvider(create: (_) => SessionViewModel()),

        ChangeNotifierProvider(
          create:
              (context) => CartService(
                orderRepository: context.read<OrderRepository>(),
                orderItemRepository: context.read<OrderItemRepository>(),
              ),
        ),

        ChangeNotifierProvider(
          create:
              (context) => HomeViewModel(
                restaurantRepository: context.read<RestaurantRepository>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => LoginViewModel(
                userRepository: context.read<UserRepository>(),
                sessionViewModel: context.read<SessionViewModel>(),
              ),
        ),
        ChangeNotifierProvider(
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
                userRepository: context.read<UserRepository>(),
                sessionViewModel: context.read<SessionViewModel>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => MenuViewModel(
                productRepository: context.read<ProductRepository>(),
              ),
        ),
      ],
      child: App(),
    ),
  );
}
