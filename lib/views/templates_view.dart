import 'package:flutter/material.dart';

import '../controllers/template_controller.dart';
import '../models/document_template.dart';

class TemplatesView extends StatelessWidget {
  final String category;

  const TemplatesView({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final TemplateController controller = TemplateController();

    final List<DocumentTemplate> templates =
        controller.getTemplates(category);

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: templates.isEmpty
          ? const Center(
              child: Text(
                'Aucun modèle disponible.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: templates.length,
              itemBuilder: (context, index) {
                final DocumentTemplate template = templates[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(
                      child: Icon(Icons.description_outlined),
                    ),
                    title: Text(
                      template.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(template.description),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      // Écran formulaire à venir.
                    },
                  ),
                );
              },
            ),
    );
  }
}