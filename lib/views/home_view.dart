import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DOCS ADMINS'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenue 👋',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Créez facilement vos documents administratifs.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Que souhaitez-vous créer ?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildCategoryCard(
              icon: Icons.work_outline,
              title: 'Lettre de motivation',
              subtitle: 'Préparez votre candidature',
              onTap: () {},
            ),

            _buildCategoryCard(
              icon: Icons.school_outlined,
              title: 'Demande de stage',
              subtitle: 'Créez votre demande de stage',
              onTap: () {},
            ),

            _buildCategoryCard(
              icon: Icons.business_center_outlined,
              title: 'Demande d’emploi',
              subtitle: 'Préparez votre demande',
              onTap: () {},
            ),

            _buildCategoryCard(
              icon: Icons.description_outlined,
              title: 'Lettres administratives',
              subtitle: 'Différents modèles administratifs',
              onTap: () {},
            ),

            _buildCategoryCard(
              icon: Icons.folder_open_outlined,
              title: 'Demandes diverses',
              subtitle: 'Autres documents utiles',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          radius: 24,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}