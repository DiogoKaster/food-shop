import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/models.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Pedido pedido;

  const OrderDetailsScreen({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido #${pedido.id}'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho do restaurante
            RestauranteHeader(restaurante: pedido.restaurante),

            const SizedBox(height: 24),

            // Status do pedido
            StatusSection(pedido: pedido),

            const SizedBox(height: 24),

            // Itens do pedido
            const Text(
              'Itens do Pedido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...pedido.itens.map((item) => OrderItemCard(item: item)),

            const SizedBox(height: 24),

            // Resumo do pedido
            const Text(
              'Resumo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            OrderSummary(pedido: pedido),

            const SizedBox(height: 32),

            // Detalhes da entrega
            const Text(
              'Detalhes da Entrega',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const DeliveryInfo(),

            const SizedBox(height: 32),

            // Botão de ajuda
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implementar lógica para solicitar ajuda
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Ajuda solicitada. Entraremos em contato em breve.',
                      ),
                    ),
                  );
                },
                child: const Text('Preciso de Ajuda'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestauranteHeader extends StatelessWidget {
  final Restaurante restaurante;

  const RestauranteHeader({super.key, required this.restaurante});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(restaurante.imagem),
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
                restaurante.nome,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Ligar para o restaurante',
                    style: TextStyle(fontSize: 14, color: Colors.blue[700]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StatusSection extends StatelessWidget {
  final Pedido pedido;

  const StatusSection({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: pedido.getStatusColor().withValues(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: pedido.getStatusColor().withValues(),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  pedido.statusTexto,
                  style: TextStyle(
                    color: pedido.getStatusColor(),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _getStatusMessage(pedido.status),
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            'Pedido realizado em ${pedido.dataFormatada}',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  String _getStatusMessage(StatusPedido status) {
    switch (status) {
      case StatusPedido.preparando:
        return 'Seu pedido está sendo preparado pelo restaurante. Você receberá uma atualização quando estiver a caminho.';
      case StatusPedido.emEntrega:
        return 'Seu pedido está a caminho! O entregador chegará em breve.';
      case StatusPedido.entregue:
        return 'Seu pedido foi entregue com sucesso. Bom apetite!';
      case StatusPedido.cancelado:
        return 'Este pedido foi cancelado.';
    }
  }
}

class OrderItemCard extends StatelessWidget {
  final ItemPedido item;

  const OrderItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(item.produto.imagem),
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
                    '${item.quantidade}x ${item.produto.nome}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.produto.descricao,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'R\$ ${item.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final Pedido pedido;

  const OrderSummary({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    // Cálculos de exemplo para o resumo do pedido
    final subtotal = pedido.valorTotal;
    final taxaEntrega = 5.99;
    final total = subtotal + taxaEntrega;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            'Subtotal',
            'R\$ ${subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Taxa de entrega',
            'R\$ ${taxaEntrega.toStringAsFixed(2).replaceAll('.', ',')}',
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Total',
            'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            Icons.location_on,
            'Endereço de entrega',
            'Rua Exemplo, 123 - Bairro - Cidade',
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.access_time, 'Tempo estimado', '30-45 minutos'),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.payment,
            'Forma de pagamento',
            'Cartão de crédito - final 1234',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
