class DocumentModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String icon;
  final bool popular;

  const DocumentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
    this.popular = false,
  });
}