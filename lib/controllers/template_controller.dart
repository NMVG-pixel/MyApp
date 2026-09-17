import '../models/document_template.dart';

class TemplateController {
  List<DocumentTemplate> getTemplates(String category) {
    if (category == 'Lettre de motivation') {
      return const [
        DocumentTemplate(
          id: 'lm_classique',
          title: 'Lettre de motivation classique',
          description: 'Un modèle simple et professionnel.',
          category: 'Lettre de motivation',
        ),
        DocumentTemplate(
          id: 'lm_spontanee',
          title: 'Candidature spontanée',
          description: 'Pour proposer votre candidature directement.',
          category: 'Lettre de motivation',
        ),
        DocumentTemplate(
          id: 'lm_emploi',
          title: 'Réponse à une offre d’emploi',
          description: 'Pour répondre à une offre précise.',
          category: 'Lettre de motivation',
        ),
      ];
    }

    if (category == 'Demande de stage') {
      return const [
        DocumentTemplate(
          id: 'stage_academique',
          title: 'Demande de stage académique',
          description: 'Pour un stage lié à votre formation.',
          category: 'Demande de stage',
        ),
        DocumentTemplate(
          id: 'stage_professionnel',
          title: 'Demande de stage professionnel',
          description: 'Pour une immersion en entreprise.',
          category: 'Demande de stage',
        ),
      ];
    }

    if (category == 'Demande d’emploi') {
      return const [
        DocumentTemplate(
          id: 'emploi_classique',
          title: 'Demande d’emploi classique',
          description: 'Un modèle pour une demande d’emploi.',
          category: 'Demande d’emploi',
        ),
      ];
    }

    if (category == 'Lettres administratives') {
      return const [
        DocumentTemplate(
          id: 'lettre_admin',
          title: 'Lettre administrative',
          description: 'Un modèle administratif général.',
          category: 'Lettres administratives',
        ),
      ];
    }

    if (category == 'Demandes diverses') {
      return const [
        DocumentTemplate(
          id: 'demande_generale',
          title: 'Demande générale',
          description: 'Pour différents types de demandes.',
          category: 'Demandes diverses',
        ),
      ];
    }

    return [];
  }
}