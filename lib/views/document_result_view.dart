import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../models/document_model.dart';

class DocumentResultView extends StatelessWidget {
  final DocumentModel document;
  final Map<String, String> formData;
  final Uint8List pdfBytes;

  const DocumentResultView({
    super.key,
    required this.document,
    required this.formData,
    required this.pdfBytes,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF000666);
    const textColor = Color(0xFF1A1C1C);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Document généré'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: textColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // PROGRESSION FINALE
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              15,
              20,
              10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Étape 3 sur 3',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Terminé',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 1,
                    minHeight: 7,
                    backgroundColor: Color(0xFFE0E0E0),
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: PdfPreview(
              build: (format) async {
                return pdfBytes;
              },
              allowPrinting: true,
              allowSharing: true,
              canChangePageFormat: false,
              canChangeOrientation: false,
              maxPageWidth: 700,
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              20,
            ),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await Printing.sharePdf(
                        bytes: pdfBytes,
                        filename: _fileName(),
                      );
                    },
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Partager'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: const BorderSide(
                        color: primaryColor,
                      ),
                      minimumSize: const Size(
                        double.infinity,
                        52,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Printing.layoutPdf(
                        onLayout: (format) async {
                          return pdfBytes;
                        },
                      );
                    },
                    icon: const Icon(Icons.print_outlined),
                    label: const Text('Imprimer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(
                        double.infinity,
                        52,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fileName() {
    String name = document.title
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^a-z0-9_]+'), '');

    if (name.isEmpty) {
      name = 'document';
    }

    return '$name.pdf';
  }
}