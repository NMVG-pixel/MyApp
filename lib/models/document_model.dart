class DocumentModel {
  final String id;
  final String title;
  final String description;
  final String category;

  // Type précis du document.
  final String type;

  // Variante ou contexte.
  final String variant;

  final String icon;
  final bool popular;

  const DocumentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.type,
    required this.variant,
    required this.icon,
    this.popular = false,
  });
}