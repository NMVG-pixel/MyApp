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

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF000666);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TEST - Prévisualisation'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Écran de test',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              document.title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  print('======= BOUTON CLIQUE =======');

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'LE CLIC FONCTIONNE !',
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return DocumentGeneratingView(
                          document: document,
                          formData: formData,
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'TESTER LE BOUTON',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}