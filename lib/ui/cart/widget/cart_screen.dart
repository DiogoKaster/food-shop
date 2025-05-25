import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Restaurante
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.red,
                child: Icon(Icons.restaurant, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sr Marmita',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Itens do carrinho
          Text(
            'Itens do carrinho',
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildCartItem(),

          const SizedBox(height: 16),

          // Endereço de entrega
          Text(
            'Endereço de entrega',
            style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_pin, color: Colors.black54),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Rua Exemplo, 123',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Bairro - Complemento',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                ),
                child: const Text('Trocar'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Opções de entrega
          Text(
            'Frete',
            style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Padrão',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Hoje, 23 - 33min',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'R\$ 3,99',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Formas de pagamento
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Formas de pagamento',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                ),
                child: const Text('Trocar'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.payment, size: 28, color: Colors.teal),
              const SizedBox(width: 12),
              Text('Pix', style: textTheme.titleMedium),
            ],
          ),

          const SizedBox(height: 24),

          // Resumo de valores
          Text(
            'Resumo de valores',
            style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildResumoItem('Subtotal', 'R\$ 15,90'),
          _buildResumoItem('Taxa de entrega', 'R\$ 3,99'),

          const Divider(),
          _buildResumoItem('Total', 'R\$ 19,89', isTotal: true),

          const SizedBox(height: 24),

          // Botão
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                //Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Pedido finalizado!')));
              },
              child: const Text(
                'Finalizar pedido',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            /*ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/cardano.png',
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),*/
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Marmita Tradicional',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Arroz, feijão, carne e salada',
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'R\$ 15,90',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumoItem(
    String title,
    String value, {
    bool isGreen = false,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                isTotal ? const TextStyle(fontWeight: FontWeight.bold) : null,
          ),
          Text(
            value,
            style: TextStyle(
              color: isGreen ? Colors.green : null,
              fontWeight: isTotal ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }
}
