import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/core/ui/menu_item_card.dart';
import 'package:flutter_application_2/ui/menu/view_model/menu_view_model.dart';
import 'package:provider/provider.dart';

class MenuProductList extends StatelessWidget {
  const MenuProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuViewModel>(
      builder: (context, menuViewModel, _) {
        if (menuViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (menuViewModel.errorMessage != null) {
          return Center(child: Text(menuViewModel.errorMessage!));
        }

        if (menuViewModel.products.isEmpty) {
          return const Center(child: Text('Nenhum produto encontrado.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: menuViewModel.products.length,
          itemBuilder: (context, index) {
            final product = menuViewModel.products[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MenuItemCard(
                nome: product.name,
                descricao: product.description,
                preco: product.price,
                onTap: () {
                  _mostrarPopup(context, product.name, product.price);
                },
              ),
            );
          },
        );
      },
    );
  }

  void _mostrarPopup(BuildContext context, String nome, double preco) {
    int quantidade = 1;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
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
                      Text('$quantidade', style: const TextStyle(fontSize: 18)),
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
                      'Adicionar    R\$ ${(preco * quantidade).toStringAsFixed(2)}',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
