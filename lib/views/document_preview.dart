import 'package:flutter/material.dart';

import '../models/document_model.dart';
import 'document_generating_view.dart';

class DocumentPreviewView extends StatelessWidget {
  final DocumentModel document;
  final Map<String, String> formData;

  const DocumentPreviewView({
    super.key,
    required this.document,
    required this.formData,
  });

  static const Color primaryColor = Color(0xFF000666);
  static const Color backgroundColor = Color(0xFFF9F9F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
        ),
        title: const Text(
          'Prévisualisation',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          24,
          20,
          130,
        ),
        child: Column(
          children: [
            // =========================
            // APERÇU DU DOCUMENT
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                28,
                32,
                28,
                32,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PRÉVISUALISATION',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.5,
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      formData['desired_date'] ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    formData['full_name'] ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    formData['phone'] ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),

                  Text(
                    formData['email'] ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 35),

                  Text(
                    'Objet : ${document.title}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Madame, Monsieur,',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    _buildDocumentText(),
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 24),

                  if ((formData['message'] ?? '').isNotEmpty) ...[
                    const Text(
                      'Informations complémentaires :',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      formData['message']!,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.7,
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],

                  const Text(
                    'Dans l’attente de votre réponse, veuillez agréer, Madame, Monsieur, l’expression de mes salutations distinguées.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 35),

                  Text(
                    formData['full_name'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =========================
            // MESSAGE
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD3E2ED),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: primaryColor,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Vérifiez attentivement les informations avant de générer votre document.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // =========================
      // BOUTON
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
            height: 62,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentGeneratingView(
                      document: document,
                      formData: formData,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF252C8F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Text(
                'Générer mon document',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _buildDocumentText() {
    if (document.id == 'demande_stage') {
      final school = formData['school'] ?? '';
      final training = formData['training'] ?? '';
      final company = formData['company'] ?? '';
      final manager = formData['manager'] ?? '';

      return '''
Actuellement étudiant(e) à $school en $training, je souhaite effectuer un stage au sein de votre structure.

Par la présente, je me permets donc de solliciter l'opportunité d'effectuer ce stage au sein de votre entreprise$company${manager.isNotEmpty ? ', sous votre supervision' : ''}.

Ce stage me permettrait de mettre en pratique mes connaissances, de développer mes compétences et d’acquérir une expérience professionnelle concrète.

Je reste à votre disposition pour tout renseignement complémentaire.
''';
    }

    return '''
Je me permets de vous adresser cette demande concernant le document « ${document.title} ».

Je souhaite par la présente vous soumettre ma demande et reste disponible pour fournir toute information complémentaire nécessaire à son étude.
''';
  }
}