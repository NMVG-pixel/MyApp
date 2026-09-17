import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import '../models/document_category.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = HomeController();
    final List<DocumentCategory> categories = controller.getCategories();

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
      body: ListView(
        padding: const EdgeInsets.all(20),
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
            'Créez facilement vos documents.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
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

          ...categories.map(
            (category) => _buildCategoryCard(category),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(DocumentCategory category) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(_getIcon(category.icon)),
        ),
        title: Text(
          category.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(category.description),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: () {
          // Navigation vers les modèles à venir.
        },
      ),
    );
  }

  IconData _getIcon(String icon) {
    switch (icon) {
      case 'work':
        return Icons.work_outline;
      case 'school':
        return Icons.school_outlined;
      case 'business':
        return Icons.business_center_outlined;
      case 'description':
        return Icons.description_outlined;
      case 'folder':
        return Icons.folder_open_outlined;
      default:
        return Icons.description_outlined;
    }
  }
}