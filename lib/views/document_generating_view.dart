import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/document_model.dart';
import '../services/document_pdf_service.dart';
import 'document_result_view.dart';

class DocumentGeneratingView extends StatefulWidget {
  final DocumentModel document;
  final Map<String, String> formData;

  const DocumentGeneratingView({
    super.key,
    required this.document,
    required this.formData,
  });

  @override
  State<DocumentGeneratingView> createState() =>
      _DocumentGeneratingViewState();
}

class _DocumentGeneratingViewState
    extends State<DocumentGeneratingView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _generateDocument();
  }

  Future<void> _generateDocument() async {
    try {
      // Permet de laisser apparaître clairement l'étape 3.
      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) return;

      final Uint8List pdfBytes =
          await DocumentPdfService.generatePdf(
        document: widget.document,
        formData: widget.formData,
      );

      if (!mounted) return;

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DocumentResultView(
            document: widget.document,
            formData: widget.formData,
            pdfBytes: pdfBytes,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Génération'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1C1C),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // =========================
              // PROGRESSION
              // =========================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Étape 3 sur 3',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000666),
                    ),
                  ),
                  Text(
                    'Génération',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF454652),
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
                  color: Color(0xFF000666),
                ),
              ),

              Expanded(
                child: Center(
                  child: _errorMessage != null
                      ? _buildError()
                      : _buildLoading(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: Tween<double>(
            begin: 0.90,
            end: 1.08,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF000666).withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.picture_as_pdf_outlined,
              size: 50,
              color: Color(0xFF000666),
            ),
          ),
        ),

        const SizedBox(height: 30),

        const Text(
          'Génération de votre document',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1C1C),
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'Votre fichier PDF est en cours de préparation.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF454652),
          ),
        ),

        const SizedBox(height: 30),

        const SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Color(0xFF000666),
          ),
        ),
      ],
    );
  }

  Widget _buildError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 70,
          color: Colors.red,
        ),

        const SizedBox(height: 20),

        const Text(
          'Une erreur est survenue',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          _errorMessage ?? 'Erreur inconnue',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.red,
          ),
        ),

        const SizedBox(height: 25),

        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _errorMessage = null;
              });

              _generateDocument();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF000666),
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Réessayer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}