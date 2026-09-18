import '../models/document_model.dart';
import '../models/form_field_model.dart';

class DocumentFormController {
  List<FormFieldModel> getFields(DocumentModel document) {
    if (document.id == 'demande_stage') {
      return const [
        FormFieldModel(
          id: 'full_name',
          label: 'Nom complet',
          hint: 'Jean Dupont',
          section: 'Vos informations',
        ),
        FormFieldModel(
          id: 'phone',
          label: 'Téléphone',
          hint: '06 12 34 56 78',
          section: 'Vos informations',
        ),
        FormFieldModel(
          id: 'email',
          label: 'Adresse e-mail',
          hint: 'jean.dupont@email.com',
          section: 'Vos informations',
        ),
        FormFieldModel(
          id: 'school',
          label: 'Établissement',
          hint: 'Université de Paris',
          section: 'Détails du stage',
        ),
        FormFieldModel(
          id: 'training',
          label: 'Formation',
          hint: 'Master Informatique',
          section: 'Détails du stage',
        ),
        FormFieldModel(
          id: 'company',
          label: 'Entreprise ciblée',
          hint: 'TechCorp',
          section: 'Détails du stage',
        ),
        FormFieldModel(
          id: 'manager',
          label: 'Nom du responsable',
          hint: 'Marie Curie',
          section: 'Détails du stage',
        ),
        FormFieldModel(
          id: 'desired_date',
          label: 'Date souhaitée',
          hint: 'mm/dd/yyyy',
          section: 'Détails du stage',
          dateField: true,
        ),
        FormFieldModel(
          id: 'message',
          label: 'Message complémentaire (optionnel)',
          hint: 'Ajoutez toute information utile pour votre demande...',
          section: 'Informations complémentaires',
          required: false,
          multiline: true,
        ),
      ];
    }

    return const [
      FormFieldModel(
        id: 'full_name',
        label: 'Nom complet',
        hint: 'Jean Dupont',
        section: 'Vos informations',
      ),
      FormFieldModel(
        id: 'phone',
        label: 'Téléphone',
        hint: '06 12 34 56 78',
        section: 'Vos informations',
      ),
      FormFieldModel(
        id: 'email',
        label: 'Adresse e-mail',
        hint: 'jean.dupont@email.com',
        section: 'Vos informations',
      ),
    ];
  }
}