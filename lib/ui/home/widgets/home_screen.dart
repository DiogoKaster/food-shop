import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/menu/widgets/menu_screen.dart';

/*class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: const Center(child: Text('Bem-vindo à Home Page!')),
    );
  }
}*/

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> restaurantes = [
    {'nome': 'Marmitas Mamma-mia', 'imagem': 'assets/bitcoin.png'},
    {'nome': 'My Mita - Refeições Express', 'imagem': 'assets/cardano.png'},
    {'nome': 'Sr Marmita', 'imagem': 'assets/ethereum.png'},
    {'nome': 'Crazyfood - Marmita & Marmitex', 'imagem': 'assets/litecoin.png'},
    {'nome': 'Restaurante Elite - Centro', 'imagem': 'assets/usdcoin.png'},
    {'nome': 'Casa da Vó', 'imagem': 'assets/xrp.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView.builder(
        itemCount: restaurantes.length,
        itemBuilder: (context, index) {
          final restaurante = restaurantes[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      //(context) =>MenuScreen(nomeRestaurante: restaurante['nome']!),
                      (context) => MenuScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(restaurante['imagem']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      restaurante['nome']!,
                      style: TextStyle(
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Busca'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
