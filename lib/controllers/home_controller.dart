import '../models/document_category.dart';

class HomeController {
  List<DocumentCategory> getCategories() {
  return const [
    DocumentCategory(
      title: 'Études',
      description: 'Documents liés aux études',
      icon: 'school',
    ),
    DocumentCategory(
      title: 'Emploi',
      description: 'Documents liés à l’emploi',
      icon: 'business',
    ),
    DocumentCategory(
      title: 'Administration',
      description: 'Démarches administratives',
      icon: 'administration',
    ),
    DocumentCategory(
      title: 'Lettres',
      description: 'Lettres professionnelles',
      icon: 'mail',
    ),
    DocumentCategory(
      title: 'Attestations',
      description: 'Différentes attestations',
      icon: 'verified',
    ),
  ];
}
}