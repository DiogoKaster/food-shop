import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/core/ui/nav_bar.dart';
import 'package:flutter_application_2/ui/home/widgets/home_screen.dart';
import 'package:flutter_application_2/ui/order/widget/order_screen.dart';
import 'package:flutter_application_2/ui/search/widget/search_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _selectedIndex = 3;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrderScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  final String _userName = "Usuário Exemplo";
  final String _userEmail = "usuario.exemplo@email.com";
  final String _profileImageUrl = "https://via.placeholder.com/150";

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_profileImageUrl),
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(height: 16.0),
                Text(
                  _userName,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  _userEmail,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32.0),
          ListTile(
            leading: Icon(Icons.edit, color: colorScheme.primary),
            title: const Text('Editar Perfil'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ação: Editar Perfil')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.settings, color: colorScheme.primary),
            title: const Text('Configurações'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ação: Configurações')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.notifications, color: colorScheme.primary),
            title: const Text('Notificações'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ação: Notificações')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.help_outline, color: colorScheme.primary),
            title: const Text('Ajuda & Suporte'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ação: Ajuda & Suporte')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red[700]),
            title: Text('Sair', style: TextStyle(color: Colors.red[700])),
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Ação: Sair')));
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
