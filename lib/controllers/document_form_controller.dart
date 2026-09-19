import '../models/document_model.dart';
import '../models/form_field_model.dart';

class DocumentFormController {
  List<FormFieldModel> getFields(DocumentModel document) {
    switch (document.id) {
      // =====================================================
      // DEMANDES DE STAGE
      // =====================================================

      case 'stage_academique':
      case 'stage_professionnel':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Votre nom et prénom',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'phone',
            label: 'Téléphone',
            hint: 'Votre numéro de téléphone',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'email',
            label: 'Adresse e-mail',
            hint: 'Votre adresse e-mail',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'school',
            label: 'Établissement',
            hint: 'Nom de votre établissement',
            section: 'Détails du stage',
          ),
          FormFieldModel(
            id: 'training',
            label: 'Formation',
            hint: 'Votre formation',
            section: 'Détails du stage',
          ),
          FormFieldModel(
            id: 'company',
            label: 'Entreprise ou organisme',
            hint: 'Nom de la structure ciblée',
            section: 'Détails du stage',
          ),
          FormFieldModel(
            id: 'position',
            label: 'Service ou poste souhaité',
            hint: 'Service ou domaine souhaité',
            section: 'Détails du stage',
          ),
          FormFieldModel(
            id: 'desired_date',
            label: 'Date souhaitée',
            hint: 'Sélectionnez une date',
            section: 'Détails du stage',
            dateField: true,
          ),
          FormFieldModel(
            id: 'message',
            label: 'Message complémentaire',
            hint: 'Ajoutez une information utile...',
            section: 'Informations complémentaires',
            required: false,
            multiline: true,
          ),
        ];

      // =====================================================
      // LETTRE DE MOTIVATION - OFFRE
      // =====================================================

      case 'motivation_offre':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Votre nom et prénom',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'phone',
            label: 'Téléphone',
            hint: 'Votre numéro de téléphone',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'email',
            label: 'Adresse e-mail',
            hint: 'Votre adresse e-mail',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'company',
            label: 'Entreprise',
            hint: 'Nom de l’entreprise',
            section: 'Candidature',
          ),
          FormFieldModel(
            id: 'position',
            label: 'Poste visé',
            hint: 'Intitulé du poste',
            section: 'Candidature',
          ),
          FormFieldModel(
            id: 'reference',
            label: 'Référence de l’offre',
            hint: 'Référence de l’annonce',
            section: 'Candidature',
            required: false,
          ),
          FormFieldModel(
            id: 'skills',
            label: 'Compétences principales',
            hint: 'Présentez brièvement vos principales compétences...',
            section: 'Candidature',
            multiline: true,
          ),
          FormFieldModel(
            id: 'message',
            label: 'Informations complémentaires',
            hint: 'Autres informations utiles...',
            section: 'Informations complémentaires',
            required: false,
            multiline: true,
          ),
        ];

      // =====================================================
      // LETTRE DE MOTIVATION - CANDIDATURE SPONTANÉE
      // =====================================================

      case 'motivation_spontanee':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Votre nom et prénom',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'phone',
            label: 'Téléphone',
            hint: 'Votre numéro de téléphone',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'email',
            label: 'Adresse e-mail',
            hint: 'Votre adresse e-mail',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'company',
            label: 'Entreprise ciblée',
            hint: 'Nom de l’entreprise',
            section: 'Candidature',
          ),
          FormFieldModel(
            id: 'domain',
            label: 'Domaine recherché',
            hint: 'Ex. Informatique, comptabilité...',
            section: 'Candidature',
          ),
          FormFieldModel(
            id: 'position',
            label: 'Poste recherché',
            hint: 'Poste ou fonction souhaitée',
            section: 'Candidature',
          ),
          FormFieldModel(
            id: 'skills',
            label: 'Compétences',
            hint: 'Vos principales compétences...',
            section: 'Candidature',
            multiline: true,
          ),
          FormFieldModel(
            id: 'message',
            label: 'Message complémentaire',
            hint: 'Informations supplémentaires...',
            section: 'Informations complémentaires',
            required: false,
            multiline: true,
          ),
        ];

      // =====================================================
      // DEMANDE D'EMPLOI - CANDIDATURE SPONTANÉE
      // =====================================================

      case 'emploi_spontane':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Votre nom et prénom',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'phone',
            label: 'Téléphone',
            hint: 'Votre numéro de téléphone',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'email',
            label: 'Adresse e-mail',
            hint: 'Votre adresse e-mail',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'company',
            label: 'Entreprise',
            hint: 'Nom de l’entreprise ciblée',
            section: 'Candidature',
          ),
          FormFieldModel(
            id: 'domain',
            label: 'Domaine recherché',
            hint: 'Domaine dans lequel vous recherchez un emploi',
            section: 'Candidature',
          ),
          FormFieldModel(
            id: 'position',
            label: 'Poste recherché',
            hint: 'Poste souhaité',
            section: 'Candidature',
          ),
          FormFieldModel(
            id: 'experience',
            label: 'Expérience professionnelle',
            hint: 'Décrivez brièvement votre expérience...',
            section: 'Candidature',
            multiline: true,
          ),
          FormFieldModel(
            id: 'message',
            label: 'Message complémentaire',
            hint: 'Autres informations...',
            section: 'Informations complémentaires',
            required: false,
            multiline: true,
          ),
        ];

      // =====================================================
      // DEMANDE D'EMPLOI - RÉPONSE À UNE OFFRE
      // =====================================================

      case 'emploi_offre':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Votre nom et prénom',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'phone',
            label: 'Téléphone',
            hint: 'Votre numéro de téléphone',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'email',
            label: 'Adresse e-mail',
            hint: 'Votre adresse e-mail',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'company',
            label: 'Entreprise',
            hint: 'Nom de l’entreprise',
            section: 'Candidature',
          ),
          FormFieldModel(
            id: 'position',
            label: 'Poste concerné',
            hint: 'Intitulé du poste',
            section: 'Candidature',
          ),
          FormFieldModel(
            id: 'reference',
            label: 'Référence de l’offre',
            hint: 'Référence de l’annonce',
            section: 'Candidature',
            required: false,
          ),
          FormFieldModel(
            id: 'experience',
            label: 'Expérience professionnelle',
            hint: 'Décrivez votre expérience...',
            section: 'Candidature',
            multiline: true,
          ),
        ];

      // =====================================================
      // DEMANDE ADMINISTRATIVE
      // =====================================================

      case 'demande_administrative':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Votre nom et prénom',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'phone',
            label: 'Téléphone',
            hint: 'Votre numéro',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'email',
            label: 'Adresse e-mail',
            hint: 'Votre adresse e-mail',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'recipient',
            label: 'Destinataire',
            hint: 'Nom, fonction ou service',
            section: 'Destinataire',
          ),
          FormFieldModel(
            id: 'subject',
            label: 'Objet de la demande',
            hint: 'Objet de votre demande',
            section: 'Demande',
          ),
          FormFieldModel(
            id: 'request',
            label: 'Votre demande',
            hint: 'Expliquez votre demande...',
            section: 'Demande',
            multiline: true,
          ),
        ];

      // =====================================================
      // LETTRE ADMINISTRATIVE
      // =====================================================

      case 'lettre_administrative':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Votre nom et prénom',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'address',
            label: 'Adresse',
            hint: 'Votre adresse',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'phone',
            label: 'Téléphone',
            hint: 'Votre numéro',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'recipient',
            label: 'Destinataire',
            hint: 'Nom et fonction du destinataire',
            section: 'Destinataire',
          ),
          FormFieldModel(
            id: 'subject',
            label: 'Objet',
            hint: 'Objet de la lettre',
            section: 'Lettre',
          ),
          FormFieldModel(
            id: 'request',
            label: 'Contenu de la demande',
            hint: 'Rédigez les éléments principaux de votre demande...',
            section: 'Lettre',
            multiline: true,
          ),
        ];

      // =====================================================
      // ATTESTATION DE SCOLARITÉ
      // =====================================================

      case 'attestation_scolarite':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet de l’étudiant',
            hint: 'Nom et prénom',
            section: 'Informations de l’étudiant',
          ),
          FormFieldModel(
            id: 'school',
            label: 'Établissement',
            hint: 'Nom de l’établissement',
            section: 'Informations scolaires',
          ),
          FormFieldModel(
            id: 'training',
            label: 'Filière / Formation',
            hint: 'Votre filière',
            section: 'Informations scolaires',
          ),
          FormFieldModel(
            id: 'level',
            label: 'Niveau d’étude',
            hint: 'Ex. Licence 2',
            section: 'Informations scolaires',
          ),
          FormFieldModel(
            id: 'academic_year',
            label: 'Année académique',
            hint: 'Ex. 2026-2027',
            section: 'Informations scolaires',
          ),
          FormFieldModel(
            id: 'registration_number',
            label: 'Numéro de matricule',
            hint: 'Votre matricule',
            section: 'Informations scolaires',
            required: false,
          ),
        ];

      // =====================================================
      // ATTESTATION DE PRÉSENCE
      // =====================================================

      case 'attestation_presence':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Nom et prénom',
            section: 'Informations de la personne',
          ),
          FormFieldModel(
            id: 'company',
            label: 'Entreprise / organisme',
            hint: 'Nom de la structure',
            section: 'Informations professionnelles',
          ),
          FormFieldModel(
            id: 'position',
            label: 'Poste occupé',
            hint: 'Fonction',
            section: 'Informations professionnelles',
          ),
          FormFieldModel(
            id: 'start_date',
            label: 'Date de début',
            hint: 'Sélectionnez une date',
            section: 'Période',
            dateField: true,
          ),
          FormFieldModel(
            id: 'end_date',
            label: 'Date de fin',
            hint: 'Sélectionnez une date',
            section: 'Période',
            required: false,
            dateField: true,
          ),
        ];

      // =====================================================
      // ATTESTATION DE TRAVAIL
      // =====================================================

      case 'attestation_travail':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Nom et prénom',
            section: 'Informations du salarié',
          ),
          FormFieldModel(
            id: 'company',
            label: 'Entreprise',
            hint: 'Nom de l’entreprise',
            section: 'Informations professionnelles',
          ),
          FormFieldModel(
            id: 'position',
            label: 'Poste occupé',
            hint: 'Fonction',
            section: 'Informations professionnelles',
          ),
          FormFieldModel(
            id: 'start_date',
            label: 'Date d’embauche',
            hint: 'Sélectionnez une date',
            section: 'Informations professionnelles',
            dateField: true,
          ),
        ];

      // =====================================================
      // ATTESTATION DE STAGE
      // =====================================================

      case 'attestation_stage':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Nom et prénom',
            section: 'Informations du stagiaire',
          ),
          FormFieldModel(
            id: 'school',
            label: 'Établissement',
            hint: 'Nom de l’établissement',
            section: 'Informations du stagiaire',
          ),
          FormFieldModel(
            id: 'training',
            label: 'Formation',
            hint: 'Formation suivie',
            section: 'Informations du stagiaire',
          ),
          FormFieldModel(
            id: 'company',
            label: 'Entreprise / organisme',
            hint: 'Lieu du stage',
            section: 'Informations du stage',
          ),
          FormFieldModel(
            id: 'position',
            label: 'Service / fonction',
            hint: 'Service ou domaine',
            section: 'Informations du stage',
          ),
          FormFieldModel(
            id: 'start_date',
            label: 'Date de début',
            hint: 'Sélectionnez une date',
            section: 'Période du stage',
            dateField: true,
          ),
          FormFieldModel(
            id: 'end_date',
            label: 'Date de fin',
            hint: 'Sélectionnez une date',
            section: 'Période du stage',
            dateField: true,
          ),
        ];

      // =====================================================
      // LETTRE PROFESSIONNELLE
      // =====================================================

      case 'lettre_professionnelle':
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Votre nom et prénom',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'phone',
            label: 'Téléphone',
            hint: 'Votre numéro',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'email',
            label: 'Adresse e-mail',
            hint: 'Votre adresse e-mail',
            section: 'Vos informations',
          ),
          FormFieldModel(
            id: 'recipient',
            label: 'Destinataire',
            hint: 'Nom et fonction',
            section: 'Destinataire',
          ),
          FormFieldModel(
            id: 'subject',
            label: 'Objet',
            hint: 'Objet de la lettre',
            section: 'Lettre',
          ),
          FormFieldModel(
            id: 'request',
            label: 'Contenu',
            hint: 'Rédigez les éléments principaux...',
            section: 'Lettre',
            multiline: true,
          ),
        ];

      default:
        return const [
          FormFieldModel(
            id: 'full_name',
            label: 'Nom complet',
            hint: 'Votre nom et prénom',
            section: 'Vos informations',
          ),
        ];
    }
  }
}