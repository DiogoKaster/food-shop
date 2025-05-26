import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/cart/widget/cart_screen.dart';

class MenuScreen extends StatelessWidget {
  final String restauranteName;
  final String restauranteImage;

  const MenuScreen({
    super.key,
    required this.restauranteName,
    required this.restauranteImage,
  });

  void _mostrarPopup(BuildContext context, String nome, String preco) {
    int quantidade = 1;
    double precoDouble =
        double.tryParse(
          preco.replaceAll(RegExp(r'[^\d,]'), '').replaceAll(',', '.'),
        ) ??
        0;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (context, setState) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(nome, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (quantidade > 1) setState(() => quantidade--);
                          },
                        ),
                        Text(
                          '$quantidade',
                          style: const TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() => quantidade++),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '$quantidade x $nome adicionado ao carrinho',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Adicionar    R\$ ${(precoDouble * quantidade).toStringAsFixed(2)}',
                      ),
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(restauranteName),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Cardápio',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                MenuItemCard(
                  nome: 'Marmita Tradicional',
                  descricao: 'Arroz, feijão, carne e salada',
                  preco: 'R\$ 15,90',
                  onTap:
                      () => _mostrarPopup(
                        context,
                        'Marmita Tradicional',
                        '15,90',
                      ),
                ),
                const SizedBox(height: 10),
                MenuItemCard(
                  nome: 'Marmita Fitness',
                  descricao: 'Arroz integral, frango grelhado e legumes',
                  preco: 'R\$ 18,90',
                  onTap:
                      () => _mostrarPopup(context, 'Marmita Fitness', '18,90'),
                ),
                const SizedBox(height: 10),
                MenuItemCard(
                  nome: 'Marmita Vegetariana',
                  descricao: 'Arroz, legumes, proteína de soja e salada',
                  preco: 'R\$ 16,90',
                  onTap:
                      () => _mostrarPopup(
                        context,
                        'Marmita Vegetariana',
                        '16,90',
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Carrinho'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
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
  final VoidCallback onTap;

  const MenuItemCard({
    super.key,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      nome,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    preco,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                descricao,
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
