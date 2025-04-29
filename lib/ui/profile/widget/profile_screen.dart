import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/core/ui/nav_bar.dart'; // Verifique se este caminho está correto
import 'package:flutter_application_2/ui/home/widgets/home_screen.dart'; // Verifique se este caminho está correto
import 'package:flutter_application_2/ui/order/widget/order_screen.dart'; // Verifique se este caminho está correto
import 'package:flutter_application_2/ui/search/widget/search_screen.dart'; // Verifique se este caminho está correto

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _selectedIndex = 3; // Índice 3 corresponde ao Perfil

  void _onItemTapped(int index) {
    if (index == _selectedIndex)
      return; // Não faz nada se clicar no item já selecionado

    // Lógica de navegação baseada no índice clicado
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrderScreen()),
        );
        break;
      case 3:
        // Já estamos na tela de perfil, tecnicamente não precisaria recarregar,
        // mas mantendo a lógica original para consistência.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  // --- Dados Mockados ---
  final String _userName = "Usuário Exemplo";
  final String _userEmail = "usuario.exemplo@email.com";
  final String _profileImageUrl =
      "https://via.placeholder.com/150"; // URL de imagem placeholder

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'), // Título da AppBar
        centerTitle: true, // Centraliza o título
        backgroundColor: colorScheme.primary, // Cor de fundo da AppBar
        foregroundColor:
            colorScheme.onPrimary, // Cor do texto e ícones na AppBar
      ),
      body: ListView(
        // Usar ListView permite rolagem se o conteúdo for grande
        padding: const EdgeInsets.all(16.0), // Espaçamento interno geral
        children: <Widget>[
          // --- Seção de Informações do Usuário ---
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50, // Tamanho do avatar
                  backgroundImage: NetworkImage(
                    _profileImageUrl,
                  ), // Imagem de fundo do avatar
                  backgroundColor:
                      Colors.grey[300], // Cor de fundo caso a imagem falhe
                ),
                const SizedBox(height: 16.0), // Espaçamento vertical
                Text(
                  _userName,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ), // Estilo do nome
                ),
                const SizedBox(height: 4.0), // Espaçamento vertical
                Text(
                  _userEmail,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ), // Estilo do email
                ),
              ],
            ),
          ),

          const SizedBox(height: 32.0), // Espaçamento maior antes das opções
          // --- Seção de Opções ---
          ListTile(
            leading: Icon(
              Icons.edit,
              color: colorScheme.primary,
            ), // Ícone de editar
            title: const Text('Editar Perfil'), // Texto da opção
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ), // Seta indicativa
            onTap: () {
              // TODO: Implementar navegação para a tela de edição de perfil
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ação: Editar Perfil')),
              );
            },
          ),
          const Divider(), // Linha divisória
          ListTile(
            leading: Icon(
              Icons.settings,
              color: colorScheme.primary,
            ), // Ícone de configurações
            title: const Text('Configurações'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Implementar navegação para a tela de configurações
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ação: Configurações')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: colorScheme.primary,
            ), // Ícone de notificações
            title: const Text('Notificações'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Implementar navegação para a tela de notificações
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ação: Notificações')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.help_outline,
              color: colorScheme.primary,
            ), // Ícone de ajuda
            title: const Text('Ajuda & Suporte'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Implementar navegação para a tela de ajuda
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ação: Ajuda & Suporte')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red[700],
            ), // Ícone de sair (vermelho)
            title: Text(
              'Sair',
              style: TextStyle(
                color: Colors.red[700],
              ), // Texto "Sair" em vermelho
            ),
            onTap: () {
              // TODO: Implementar lógica de logout (limpar dados, navegar para login)
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Ação: Sair')));
              // Exemplo: Navegar para uma tela de login após o logout
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (context) => LoginScreen()), // Substitua por sua tela de login
              //   (Route<dynamic> route) => false, // Remove todas as rotas anteriores
              // );
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex, // Passa o índice atual para a NavBar
        onTap: _onItemTapped, // Passa a função de callback para a NavBar
      ),
    );
  }
}
