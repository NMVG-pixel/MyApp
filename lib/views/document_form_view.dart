import 'package:flutter/material.dart';

import '../controllers/document_form_controller.dart';
import '../models/document_model.dart';
import '../models/form_field_model.dart';
import '../views/document_preview.dart';

class DocumentFormView extends StatefulWidget {
  final DocumentModel document;

  const DocumentFormView({
    super.key,
    required this.document,
  });

  @override
  State<DocumentFormView> createState() => _DocumentFormViewState();
}

class _DocumentFormViewState extends State<DocumentFormView> {
  static const Color primaryColor = Color(0xFF000666);
  static const Color backgroundColor = Color(0xFFF9F9F9);
  static const Color textColor = Color(0xFF17191A);
  static const Color secondaryTextColor = Color(0xFF666A79);

  final DocumentFormController _controller =
      DocumentFormController();

  final Map<String, TextEditingController> _controllers = {};

  late final List<FormFieldModel> _fields;

  @override
  void initState() {
    super.initState();

    _fields = _controller.getFields(widget.document);

    for (final field in _fields) {
      _controllers[field.id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<FormFieldModel>> sections = {};

    for (final field in _fields) {
      sections.putIfAbsent(field.section, () => []);
      sections[field.section]!.add(field);
    }

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF2D3040),
            size: 30,
          ),
        ),
        title: const Text(
          'Création du document',
          style: TextStyle(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          30,
          20,
          130,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // PROGRESSION
            // =========================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Étape 1 sur 3',
                  style: TextStyle(
                    color: Color(0xFF2F303B),
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Vos informations',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: 1 / 3,
                minHeight: 5,
                backgroundColor: const Color(0xFFE8E8E8),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  primaryColor,
                ),
              ),
            ),

            const SizedBox(height: 35),

            // =========================
            // SECTIONS
            // =========================

            ...sections.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: _buildSection(
                  title: entry.key,
                  fields: entry.value,
                ),
              ),
            ),
          ],
        ),
      ),

      // =========================
      // BOUTON CONTINUER
      // =========================

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            16,
            20,
            16,
          ),
          color: Colors.white,
          child: SizedBox(
            height: 64,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _continue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF252C8F),
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continuer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(
                    Icons.arrow_forward,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<FormFieldModel> fields,
  }) {
    final bool showTitle = title != 'Vos informations';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Text(
            title,
            style: const TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
        ],

        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            22,
            22,
            22,
            18,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: fields
                .map(
                  (field) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: _buildField(field),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildField(FormFieldModel field) {
    if (field.dateField) {
      return _buildDateField(field);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label,
          style: const TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: _controllers[field.id],
          maxLines: field.multiline ? 5 : 1,
          decoration: InputDecoration(
            hintText: field.hint,
            hintStyle: const TextStyle(
              color: Color(0xFF777B89),
              fontSize: 16,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(
                color: Color(0xFF858894),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(
                color: Color(0xFF858894),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
              borderSide: BorderSide(
                color: primaryColor,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(FormFieldModel field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label,
          style: const TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: _controllers[field.id],
          readOnly: true,
          onTap: () => _selectDate(field),
          decoration: InputDecoration(
            hintText: field.hint,
            hintStyle: const TextStyle(
              color: Color(0xFF777B89),
              fontSize: 16,
            ),
            suffixIcon: const Icon(
              Icons.calendar_today_outlined,
              size: 20,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
              borderSide: BorderSide(
                color: Color(0xFF858894),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
              borderSide: BorderSide(
                color: Color(0xFF858894),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(FormFieldModel field) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    _controllers[field.id]!.text =
        '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  void _continue() {
  FocusScope.of(context).unfocus();

  final Map<String, String> formData = {};

  for (final field in _fields) {
    final String value = _controllers[field.id]?.text.trim() ?? '';

    if (field.required && value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Veuillez remplir le champ : ${field.label}',
          ),
        ),
      );
      return;
    }

    formData[field.id] = value;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DocumentPreviewView(
        document: widget.document,
        formData: formData,
      ),
    ),
  );
}
}