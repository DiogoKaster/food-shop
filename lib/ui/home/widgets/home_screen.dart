import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repositories/restaurant_repository.dart';
import 'package:flutter_application_2/ui/core/ui/nav_bar.dart';
import 'package:flutter_application_2/ui/home/view_model/home_view_model.dart';
import 'package:flutter_application_2/ui/menu/widgets/menu_screen.dart';
import 'package:flutter_application_2/ui/order/widget/order_screen.dart';
import 'package:flutter_application_2/ui/profile/widget/profile_screen.dart';
import 'package:flutter_application_2/ui/search/widget/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  late final HomeViewModel viewModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel(
      restaurantRepository: InMemoryRestaurantRepository(),
    );
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    await viewModel.loadRestaurants();
    setState(() {
      isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    Widget screen;
    switch (index) {
      case 1:
        screen = const SearchScreen();
        break;
      case 2:
        screen = const OrderScreen();
        break;
      case 3:
        screen = const ProfileScreen();
        break;
      default:
        screen = const HomeScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: viewModel.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurante = viewModel.restaurants[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => MenuScreen(
                                restauranteName: restaurante.name,
                                restauranteImage: restaurante.brand,
                              ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(restaurante.brand),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              restaurante.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
