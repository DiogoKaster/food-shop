import 'package:flutter/material.dart';
import 'package:flutter_application_2/routing/app_routes.dart';
import 'package:flutter_application_2/ui/edit_profile/widget/edit_profile_screen.dart';
import 'package:flutter_application_2/ui/manage_address/widgets/manage_address_screen.dart';
import 'package:flutter_application_2/ui/profile/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final profileViewModel = context.watch<ProfileViewModel>();

    final user = profileViewModel.loggedUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await profileViewModel.pickImage();
                    setState(() {}); // força rebuild imediato com nova imagem
                  },
                  child: CircleAvatar(
                    key: UniqueKey(), // força descartar o cache da imagem
                    radius: 50,
                    backgroundColor: colorScheme.primary.withOpacity(0.1),
                    backgroundImage:
                        profileViewModel.profileImage != null
                            ? FileImage(profileViewModel.profileImage!)
                            : null,
                    child:
                        profileViewModel.profileImage == null
                            ? Icon(
                              Icons.person,
                              size: 60,
                              color: colorScheme.primary,
                            )
                            : null,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  user?.name ?? 'Nome não disponível',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  user?.email ?? 'Email não disponível',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32.0),

          ListTile(
            leading: Icon(Icons.edit, color: colorScheme.primary),
            title: const Text('Editar Perfil'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.house_outlined, color: colorScheme.primary),
            title: const Text('Gerenciar Endereço'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ManageAddressScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red[700]),
            title: Text('Sair', style: TextStyle(color: Colors.red[700])),
            onTap: () {
              profileViewModel.logout();

              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
