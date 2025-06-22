import 'package:flutter/material.dart';
import 'package:flutter_application_2/domain/models/order.dart';
import 'package:flutter_application_2/data/repositories/order_repository.dart';
import 'package:flutter_application_2/ui/order/view_model/order_view_model.dart';
import 'package:flutter_application_2/ui/shared/session_view_model.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionViewModel>();
    final userId = session.loggedUser?.id;

    if (userId == null) {
      return const Scaffold(
        body: Center(child: Text('Usuário não está autenticado.')),
      );
    }

    return ChangeNotifierProvider(
      create:
          (_) => OrderViewModel(
            orderRepository: context.read<OrderRepository>(),
            userId: userId,
          ),
      child: const _OrderScreenContent(),
    );
  }
}

class _OrderScreenContent extends StatelessWidget {
  const _OrderScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OrderViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Builder(
        builder: (context) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          if (viewModel.orders.isEmpty) {
            return const Center(child: Text('Nenhum pedido encontrado.'));
          }

          return ListView.builder(
            itemCount: viewModel.orders.length,
            itemBuilder: (context, index) {
              final order = viewModel.orders[index];
              return _buildOrderTile(order);
            },
          );
        },
      ),
    );
  }

  Widget _buildOrderTile(Order order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text('Pedido #${order.id}'),
          subtitle: Text(
            'Status: ${order.status}\nTotal: R\$ ${order.totalPrice.toStringAsFixed(2)}',
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
