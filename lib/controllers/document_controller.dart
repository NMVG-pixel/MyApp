import '../models/document_model.dart';

class DocumentController {
  List<DocumentModel> getDocuments() {
    return const [
      // =========================
      // ÉTUDES
      // =========================

      DocumentModel(
        id: 'stage_academique',
        title: 'Demande de stage académique',
        description:
            'Demande adressée à une entreprise dans le cadre d’une formation.',
        category: 'Études',
        type: 'Demande de stage',
        variant: 'Stage académique',
        icon: 'stage',
        popular: true,
      ),

      DocumentModel(
        id: 'stage_professionnel',
        title: 'Demande de stage professionnel',
        description:
            'Demande de stage destinée à une entreprise ou organisation.',
        category: 'Études',
        type: 'Demande de stage',
        variant: 'Stage professionnel',
        icon: 'stage',
      ),

      // =========================
      // EMPLOI
      // =========================

      DocumentModel(
        id: 'motivation_offre',
        title: 'Lettre de motivation',
        description:
            'Lettre accompagnant une candidature à une offre d’emploi.',
        category: 'Emploi',
        type: 'Lettre de motivation',
        variant: 'Réponse à une offre',
        icon: 'motivation',
        popular: true,
      ),

      DocumentModel(
        id: 'motivation_spontanee',
        title: 'Lettre de motivation',
        description:
            'Lettre pour une candidature spontanée.',
        category: 'Emploi',
        type: 'Lettre de motivation',
        variant: 'Candidature spontanée',
        icon: 'motivation',
      ),

      DocumentModel(
        id: 'emploi_spontane',
        title: 'Demande d’emploi',
        description:
            'Demande d’emploi adressée directement à une entreprise.',
        category: 'Emploi',
        type: 'Demande d’emploi',
        variant: 'Candidature spontanée',
        icon: 'emploi',
        popular: true,
      ),

      DocumentModel(
        id: 'emploi_offre',
        title: 'Demande d’emploi',
        description:
            'Réponse à une offre d’emploi précise.',
        category: 'Emploi',
        type: 'Demande d’emploi',
        variant: 'Réponse à une offre',
        icon: 'emploi',
      ),

      // =========================
      // ADMINISTRATION
      // =========================

      DocumentModel(
        id: 'demande_administrative',
        title: 'Demande administrative',
        description:
            'Modèle pour effectuer une démarche auprès d’une administration.',
        category: 'Administration',
        type: 'Demande administrative',
        variant: 'Demande générale',
        icon: 'administration',
      ),

      DocumentModel(
        id: 'lettre_administrative',
        title: 'Lettre administrative',
        description:
            'Lettre destinée à une administration ou institution.',
        category: 'Administration',
        type: 'Lettre administrative',
        variant: 'Modèle standard',
        icon: 'administration',
      ),

      // =========================
      // ATTESTATIONS
      // =========================

      DocumentModel(
        id: 'attestation_scolarite',
        title: 'Attestation de scolarité',
        description:
            'Attestation confirmant l’inscription d’un étudiant.',
        category: 'Attestations',
        type: 'Attestation',
        variant: 'Attestation de scolarité',
        icon: 'attestation',
      ),

      DocumentModel(
        id: 'attestation_presence',
        title: 'Attestation de présence',
        description:
            'Attestation confirmant la présence d’une personne.',
        category: 'Attestations',
        type: 'Attestation',
        variant: 'Attestation de présence',
        icon: 'attestation',
      ),

      DocumentModel(
        id: 'attestation_travail',
        title: 'Attestation de travail',
        description:
            'Attestation confirmant l’emploi d’une personne.',
        category: 'Attestations',
        type: 'Attestation',
        variant: 'Attestation de travail',
        icon: 'attestation',
      ),

      DocumentModel(
        id: 'attestation_stage',
        title: 'Attestation de stage',
        description:
            'Attestation confirmant la réalisation d’un stage.',
        category: 'Attestations',
        type: 'Attestation',
        variant: 'Attestation de stage',
        icon: 'attestation',
      ),

      // =========================
      // LETTRES
      // =========================

      DocumentModel(
        id: 'lettre_professionnelle',
        title: 'Lettre professionnelle',
        description:
            'Lettre destinée à un contexte professionnel.',
        category: 'Lettres',
        type: 'Lettre professionnelle',
        variant: 'Modèle standard',
        icon: 'lettre',
      ),
    ];
  }

  List<DocumentModel> getDocumentsByCategory(String category) {
    return getDocuments()
        .where((document) => document.category == category)
        .toList();
  }

  List<DocumentModel> getDocumentsByType(String type) {
    return getDocuments()
        .where((document) => document.type == type)
        .toList();
  }

  List<DocumentModel> getDocumentsByVariant(String variant) {
    return getDocuments()
        .where((document) => document.variant == variant)
        .toList();
  }

  List<DocumentModel> getPopularDocuments() {
    return getDocuments()
        .where((document) => document.popular)
        .toList();
  }
}