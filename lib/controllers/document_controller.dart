import '../models/document_model.dart';

class DocumentController {
  List<DocumentModel> getDocuments() {
    return const [
      DocumentModel(
        id: 'demande_stage',
        title: 'Demande de stage',
        description:
            'Modèle standard pour une demande de stage professionnel.',
        category: 'Études',
        icon: 'stage',
        popular: true,
      ),
      DocumentModel(
        id: 'lettre_motivation',
        title: 'Lettre de motivation',
        description:
            'Lettre professionnelle pour accompagner votre candidature.',
        category: 'Emploi',
        icon: 'motivation',
        popular: true,
      ),
      DocumentModel(
        id: 'demande_emploi',
        title: 'Demande d’emploi',
        description:
            'Modèle pour une candidature à un emploi.',
        category: 'Emploi',
        icon: 'emploi',
        popular: true,
      ),
      DocumentModel(
        id: 'lettre_administrative',
        title: 'Lettre administrative',
        description:
            'Modèle de lettre destiné à une administration.',
        category: 'Administration',
        icon: 'administration',
      ),
      DocumentModel(
        id: 'demande_generale',
        title: 'Demande diverse',
        description:
            'Modèle pour différents types de demandes.',
        category: 'Lettres',
        icon: 'lettre',
      ),
      DocumentModel(
        id: 'attestation',
        title: 'Attestation',
        description:
            'Modèle pour différents types d’attestations.',
        category: 'Attestations',
        icon: 'attestation',
      ),
    ];
  }

  List<DocumentModel> getDocumentsByCategory(String category) {
    return getDocuments()
        .where((document) => document.category == category)
        .toList();
  }

  List<DocumentModel> getPopularDocuments() {
    return getDocuments()
        .where((document) => document.popular)
        .toList();
  }
}