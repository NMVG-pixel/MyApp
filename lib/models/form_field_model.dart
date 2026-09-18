class FormFieldModel {
  final String id;
  final String label;
  final String hint;
  final String section;
  final bool required;
  final bool multiline;
  final bool dateField;

  const FormFieldModel({
    required this.id,
    required this.label,
    required this.hint,
    required this.section,
    this.required = true,
    this.multiline = false,
    this.dateField = false,
  });
}