import '../models/document_template.dart';

class TemplateSelectionController {
  DocumentTemplate? selectedTemplate;

  void selectTemplate(DocumentTemplate template) {
    selectedTemplate = template;
  }
}