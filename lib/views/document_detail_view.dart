import 'package:flutter/material.dart';

import '../models/document_model.dart';
import 'document_form_view.dart';

class DocumentDetailView extends StatelessWidget {
  final DocumentModel document;

  const DocumentDetailView({
    super.key,
    required this.document,
  });

  static const Color primaryColor = Color(0xFF000666);
  static const Color secondaryBlue = Color(0xFFD3E2ED);
  static const Color backgroundColor = Color(0xFFF9F9F9);
  static const Color textColor = Color(0xFF1A1C1C);
  static const Color secondaryTextColor = Color(0xFF454652);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Détails du document',
          style: TextStyle(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // =========================
      // CONTENU
      // =========================
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          24,
          20,
          140,
        ),
        child: Column(
          children: [
            // =========================
            // PRÉSENTATION DU DOCUMENT
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                24,
                28,
                24,
                28,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE8E8E8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 165,
                    height: 165,
                    decoration: const BoxDecoration(
                      color: secondaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.description_outlined,
                      color: primaryColor,
                      size: 82,
                    ),
                  ),

                  const SizedBox(height: 36),

                  Text(
                    document.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    document.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: secondaryTextColor,
                      fontSize: 18,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // INFORMATIONS
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF252C8F),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Document disponible',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 54),

            // =========================
            // AVANTAGES
            // =========================
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ce que vous obtenez',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE8E8E8),
                ),
              ),
              child: Column(
                children: [
                  _buildBenefit(
                    icon: Icons.check_circle_outline,
                    text: 'Document professionnel',
                  ),
                  _buildDivider(),
                  _buildBenefit(
                    icon: Icons.check_circle_outline,
                    text: 'Mise en page propre',
                  ),
                  _buildDivider(),
                  _buildBenefit(
                    icon: Icons.check_circle_outline,
                    text: 'Format PDF',
                  ),
                  _buildDivider(),
                  _buildBenefit(
                    icon: Icons.check_circle_outline,
                    text: 'Téléchargement immédiat',
                  ),
                  _buildDivider(),
                  _buildBenefit(
                    icon: Icons.check_circle_outline,
                    text: 'Partage facile',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // =========================
      // BOUTON CRÉATION
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
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SizedBox(
            height: 64,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentFormView(
                      document: document,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF252C8F),
                foregroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Créer mon document',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // AVANTAGE
  // =========================
  Widget _buildBenefit({
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 19,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 30,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // SÉPARATEUR
  // =========================
  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFE2E2E2),
    );
  }
}