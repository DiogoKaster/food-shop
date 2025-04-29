import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  final String restauranteName;
  final String restauranteImage;

  const MenuScreen({
    super.key,
    required this.restauranteName,
    required this.restauranteImage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(restauranteName),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(restauranteImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Cardápio de $restauranteName',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // Aqui você pode adicionar mais informações do restaurante e seu menu
          // Por exemplo, uma lista de pratos
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                MenuItemCard(
                  nome: 'Marmita Tradicional',
                  descricao: 'Arroz, feijão, carne e salada',
                  preco: 'R\$ 15,90',
                ),
                SizedBox(height: 10),
                MenuItemCard(
                  nome: 'Marmita Fitness',
                  descricao: 'Arroz integral, frango grelhado e legumes',
                  preco: 'R\$ 18,90',
                ),
                SizedBox(height: 10),
                MenuItemCard(
                  nome: 'Marmita Vegetariana',
                  descricao: 'Arroz, legumes, proteína de soja e salada',
                  preco: 'R\$ 16,90',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final String nome;
  final String descricao;
  final String preco;

  const MenuItemCard({
    super.key,
    required this.nome,
    required this.descricao,
    required this.preco,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  preco,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              descricao,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
