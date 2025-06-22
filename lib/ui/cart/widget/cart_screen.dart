import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/services/cart_service.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<CartProduct>> _cartProductsFuture;

  @override
  void initState() {
    super.initState();
    _loadCartProducts();
  }

  void _loadCartProducts() {
    _cartProductsFuture = context.read<CartService>().getCartProducts();
  }

  Future<void> _removeItem(int productId) async {
    context.read<CartService>().removeItem(productId);
    setState(() {
      _loadCartProducts();
    });
  }

  Future<void> _finalizeOrder() async {
    try {
      await context.read<CartService>().finalizeOrder();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pedido finalizado com sucesso!')),
      );

      setState(() {
        _loadCartProducts();
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao finalizar pedido: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: FutureBuilder<List<CartProduct>>(
        future: _cartProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final cartProducts = snapshot.data ?? [];

          if (cartProducts.isEmpty) {
            return const Center(child: Text('Seu carrinho está vazio.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProducts[index];
                    final product = cartItem.product;

                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(product.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Qtd: ${cartItem.quantity} | R\$ ${(product.price * cartItem.quantity).toStringAsFixed(2)}',
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removeItem(product.id),
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
                  onPressed: _finalizeOrder,
                  child: const Text('Finalizar Pedido'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
