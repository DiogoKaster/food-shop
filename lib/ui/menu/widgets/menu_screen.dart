import 'package:flutter/material.dart';

/*class MenuScreen extends StatelessWidget {
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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
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
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}*/

/*class MenuScreen extends StatelessWidget {
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
    final textTheme =
        Theme.of(context).textTheme; // Adicionado para usar textTheme

    return Scaffold(
      appBar: AppBar(
        title: Text(restauranteName),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinha textos à esquerda
        children: [
          // --- Imagem do Restaurante ---
          Container(
            width: double.infinity,
            height: 200, // Altura da imagem
            decoration: BoxDecoration(
              image: DecorationImage(
                // Use NetworkImage se a imagem vier da internet
                // image: NetworkImage(restauranteImage),
                image: AssetImage(
                  restauranteImage,
                ), // Mantendo AssetImage conforme original
                fit: BoxFit.cover, // Cobre toda a área do container
              ),
            ),
            // Opcional: Adicionar um scrim/overlay para melhor legibilidade do texto sobre imagem
            // child: Container(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Colors.black.withOpacity(0.5), Colors.transparent],
            //       begin: Alignment.bottomCenter,
            //       end: Alignment.topCenter,
            //     ),
            //   ),
            // ),
          ),
          // Adiciona padding ao redor do conteúdo abaixo da imagem
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Cardápio', // Título da seção
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary, // Usa cor primária para destaque
              ),
            ),
          ),
          // Linha divisória (opcional)
          // const Divider(height: 1, thickness: 1),

          // --- Lista de Itens do Cardápio ---
          Expanded(
            // Garante que a lista ocupe o espaço restante
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ), // Ajusta padding da lista
              children: const [
                // Seus MenuItemCard existentes
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
                // Adicione mais itens aqui...
              ],
            ),
          ),
        ],
      ),
      // --- Botão Flutuante para Adicionar Item ---
      floatingActionButton: FloatingActionButton.extended(
        // Usando .extended para ter texto e ícone
        onPressed: () {
          // TODO: Implementar a lógica para adicionar um novo item
          // Ex: Navegar para uma tela de formulário, abrir um dialog, etc.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ação: Adicionar novo item ao cardápio'),
            ),
          );
        },
        label: const Text('Adicionar Item'), // Texto do botão
        icon: const Icon(Icons.add), // Ícone do botão
        backgroundColor:
            colorScheme.secondary, // Cor de fundo (pode ser primary também)
        foregroundColor: colorScheme.onSecondary, // Cor do texto/ícone
        tooltip: 'Adicionar item ao cardápio', // Dica ao pressionar e segurar
      ),
    );
  }
}

// Classe MenuItemCard permanece a mesma
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ), // Bordas arredondadas
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Permite que o nome quebre linha se for muito longo
                  child: Text(
                    nome,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espaço entre nome e preço
                Text(
                  preco,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700], // Tom de verde mais escuro
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              descricao,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600], // Cor mais suave para descrição
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Indo para o carrinho...')),
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
