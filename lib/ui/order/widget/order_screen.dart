import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/models.dart';
import 'package:flutter_application_2/ui/core/ui/nav_bar.dart';
import 'package:flutter_application_2/ui/home/widgets/home_screen.dart';
import 'package:flutter_application_2/ui/profile/widget/profile_screen.dart';
import 'package:flutter_application_2/ui/search/widget/search_screen.dart';
import 'package:flutter_application_2/ui/order_details/widget/order_details_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final int _selectedIndex = 2;
  List<Pedido> _pedidos = [];

  @override
  void initState() {
    super.initState();
    _pedidos = MockDataService.getPedidosDoUsuario();
  }

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body:
          _pedidos.isEmpty
              ? const Center(
                child: Text(
                  'Você ainda não possui pedidos.',
                  style: TextStyle(fontSize: 16),
                ),
              )
              : ListView.builder(
                itemCount: _pedidos.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final pedido = _pedidos[index];
                  return OrderCard(
                    pedido: pedido,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => OrderDetailsScreen(pedido: pedido),
                        ),
                      );
                    },
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

class OrderCard extends StatelessWidget {
  final Pedido pedido;
  final VoidCallback onTap;

  const OrderCard({super.key, required this.pedido, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(pedido.restaurante.imagem),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pedido.restaurante.nome,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pedido #${pedido.id}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pedido.dataFormatada,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.shopping_bag_outlined, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    '${pedido.itens.length} ${pedido.itens.length == 1 ? 'item' : 'itens'}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  Text(
                    'R\$ ${pedido.valorTotal.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: pedido.getStatusColor().withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      pedido.statusTexto,
                      style: TextStyle(
                        color: pedido.getStatusColor(),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
