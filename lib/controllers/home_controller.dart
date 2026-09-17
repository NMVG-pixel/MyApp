import '../models/document_category.dart';

class HomeController {
  List<DocumentCategory> getCategories() {
    return const [
      DocumentCategory(
        title: 'Lettre de motivation',
        description: 'Préparez votre candidature',
        icon: 'work',
      ),
      DocumentCategory(
        title: 'Demande de stage',
        description: 'Créez votre demande de stage',
        icon: 'school',
      ),
      DocumentCategory(
        title: 'Demande d’emploi',
        description: 'Préparez votre demande',
        icon: 'business',
      ),
      DocumentCategory(
        title: 'Lettres administratives',
        description: 'Différents modèles administratifs',
        icon: 'description',
      ),
      DocumentCategory(
        title: 'Demandes diverses',
        description: 'Autres documents utiles',
        icon: 'folder',
      ),
    ];
  }
}