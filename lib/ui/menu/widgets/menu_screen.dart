import 'package:flutter/material.dart';

/*class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cardápio'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: const Center(child: Text('Bem-vindo ao Cardápio!')),
    );
  }
}*/

import 'package:flutter_application_2/ui/order/widget/order_screen.dart';

class MenuScreen extends StatelessWidget {
  final String nomeRestaurante;

  MenuScreen({required this.nomeRestaurante});

  final List<Map<String, dynamic>> itens = [
    {
      'nome': 'Super Cheddar McMelt Bacon',
      'descricao':
          'Um hambúrguer (100% carne bovina), molho lácteo com queijo tipo cheddar...',
      'preco': 31.90,
    },
    {
      'nome': 'Cheddar McMelt + Bebida',
      'descricao':
          'Um hambúrguer (100% carne bovina), molho lácteo com queijo tipo cheddar...',
      'preco': 27.90,
    },
    {
      'nome': 'McFlurry Kitkat Chocolate com Coco',
      'descricao':
          'Sobremesa composta por bebida láctea sabor baunilha, cobertura sabor chocolate...',
      'preco': 17.90,
    },
  ];

  void _mostrarPopup(BuildContext context, Map<String, dynamic> item) {
    int quantidade = 1;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return StatefulBuilder(
          builder:
              (context, setState) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['nome'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.grey),
                          onPressed: () {
                            if (quantidade > 1) {
                              setState(() => quantidade--);
                            }
                          },
                        ),
                        Text('$quantidade', style: TextStyle(fontSize: 18)),
                        IconButton(
                          icon: Icon(Icons.add, color: colorScheme.primary),
                          onPressed: () {
                            setState(() => quantidade++);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 48),
                      ),
                      child: Text(
                        'Adicionar    R\$ ${(item['preco'] * quantidade).toStringAsFixed(2)}',
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

    return Scaffold(
      appBar: AppBar(
        title: Text(nomeRestaurante),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: itens.length,
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                final item = itens[index];
                return GestureDetector(
                  onTap: () => _mostrarPopup(context, item),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['nome'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        item['descricao'],
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'R\$ ${item['preco'].toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => OrderScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text('Carrinho', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
