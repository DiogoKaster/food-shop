// Arquivo: lib/models/models.dart
import 'package:flutter/material.dart';

class Produto {
  final String id;
  final String nome;
  final String descricao;
  final String imagem;
  final double preco;
  final String restauranteId;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.imagem,
    required this.preco,
    required this.restauranteId,
  });
}

class Restaurante {
  final String id;
  final String nome;
  final String imagem;

  Restaurante({
    required this.id,
    required this.nome,
    required this.imagem,
  });
}

class Cliente {
  final String id;
  final String nome;
  final String email;

  Cliente({
    required this.id,
    required this.nome,
    required this.email,
  });
}

enum StatusPedido {
  preparando,
  emEntrega,
  entregue,
  cancelado
}

class ItemPedido {
  final Produto produto;
  final int quantidade;

  ItemPedido({
    required this.produto,
    required this.quantidade,
  });

  double get subtotal => produto.preco * quantidade;
}

class Pedido {
  final String id;
  final Cliente cliente;
  final Restaurante restaurante;
  final List<ItemPedido> itens;
  final DateTime data;
  final StatusPedido status;

  Pedido({
    required this.id,
    required this.cliente,
    required this.restaurante,
    required this.itens,
    required this.data,
    required this.status,
  });

  double get valorTotal {
    return itens.fold(0, (total, item) => total + item.subtotal);
  }

  String get dataFormatada {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} - ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}';
  }

  String get statusTexto {
    switch (status) {
      case StatusPedido.preparando:
        return 'Preparando';
      case StatusPedido.emEntrega:
        return 'Em entrega';
      case StatusPedido.entregue:
        return 'Entregue';
      case StatusPedido.cancelado:
        return 'Cancelado';
    }
  }

  Color getStatusColor() {
    switch (status) {
      case StatusPedido.preparando:
        return Colors.orange;
      case StatusPedido.emEntrega:
        return Colors.blue;
      case StatusPedido.entregue:
        return Colors.green;
      case StatusPedido.cancelado:
        return Colors.red;
    }
  }
}

// Esta classe normalmente seria substituída por um serviço real
// que busca dados de uma API ou banco de dados
class MockDataService {
  static final Cliente clienteAtual = Cliente(
    id: 'c1',
    nome: 'João Silva',
    email: 'joao@email.com',
  );

  static final List<Restaurante> restaurantes = [
    Restaurante(id: 'r1', nome: 'Marmitas Mamma-mia', imagem: 'assets/bitcoin.png'),
    Restaurante(id: 'r2', nome: 'My Mita - Refeições Express', imagem: 'assets/cardano.png'),
    Restaurante(id: 'r3', nome: 'Sr Marmita', imagem: 'assets/ethereum.png'),
    Restaurante(id: 'r4', nome: 'Crazyfood - Marmita & Marmitex', imagem: 'assets/litecoin.png'),
    Restaurante(id: 'r5', nome: 'Restaurante Elite - Centro', imagem: 'assets/usdcoin.png'),
    Restaurante(id: 'r6', nome: 'Casa da Vó', imagem: 'assets/xrp.png'),
  ];

  static final List<Produto> produtos = [
    Produto(
      id: 'p1',
      nome: 'Marmita Tradicional',
      descricao: 'Arroz, feijão, carne e salada',
      imagem: 'assets/bitcoin.png',
      preco: 15.90,
      restauranteId: 'r1',
    ),
    Produto(
      id: 'p2',
      nome: 'Marmita Fitness',
      descricao: 'Arroz integral, frango grelhado e legumes',
      imagem: 'assets/bitcoin.png',
      preco: 18.90,
      restauranteId: 'r1',
    ),
    Produto(
      id: 'p3',
      nome: 'Espaguete à Bolonhesa',
      descricao: 'Macarrão com molho de tomate e carne moída',
      imagem: 'assets/cardano.png',
      preco: 16.50,
      restauranteId: 'r2',
    ),
    Produto(
      id: 'p4',
      nome: 'Feijoada Completa',
      descricao: 'Feijão preto, carnes variadas, arroz, couve e laranja',
      imagem: 'assets/ethereum.png',
      preco: 22.90,
      restauranteId: 'r3',
    ),
  ];

  static List<Pedido> getPedidosDoUsuario() {
    return [
      Pedido(
        id: 'ped001',
        cliente: clienteAtual,
        restaurante: restaurantes[0],
        itens: [
          ItemPedido(produto: produtos[0], quantidade: 2),
          ItemPedido(produto: produtos[1], quantidade: 1),
        ],
        data: DateTime.now().subtract(const Duration(hours: 1)),
        status: StatusPedido.preparando,
      ),
      Pedido(
        id: 'ped002',
        cliente: clienteAtual,
        restaurante: restaurantes[1],
        itens: [
          ItemPedido(produto: produtos[2], quantidade: 3),
        ],
        data: DateTime.now().subtract(const Duration(days: 1)),
        status: StatusPedido.emEntrega,
      ),
      Pedido(
        id: 'ped003',
        cliente: clienteAtual,
        restaurante: restaurantes[2],
        itens: [
          ItemPedido(produto: produtos[3], quantidade: 1),
        ],
        data: DateTime.now().subtract(const Duration(days: 3)),
        status: StatusPedido.entregue,
      ),
      Pedido(
        id: 'ped004',
        cliente: clienteAtual,
        restaurante: restaurantes[0],
        itens: [
          ItemPedido(produto: produtos[0], quantidade: 1),
          ItemPedido(produto: produtos[1], quantidade: 1),
        ],
        data: DateTime.now().subtract(const Duration(days: 7)),
        status: StatusPedido.cancelado,
      ),
    ];
  }
}
