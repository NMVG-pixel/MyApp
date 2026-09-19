import 'package:flutter/material.dart';

import '../controllers/document_controller.dart';
import '../models/document_model.dart';
import 'document_detail_view.dart';

class DocumentsView extends StatefulWidget {
  final String initialCategory;

  const DocumentsView({
    super.key,
    this.initialCategory = 'Tous',
  });

  @override
  State<DocumentsView> createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView> {
  final DocumentController _controller = DocumentController();

  late List<DocumentModel> _documents;

  final List<String> _categories = const [
    'Tous',
    'Études',
    'Emploi',
    'Administration',
    'Lettres',
    'Attestations',
  ];

  String _selectedCategory = 'Tous';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _documents = _controller.getDocuments();

    if (_categories.contains(widget.initialCategory)) {
      _selectedCategory = widget.initialCategory;
    }
  }

  List<DocumentModel> get _filteredDocuments {
    return _documents.where((document) {
      final bool matchesCategory =
          _selectedCategory == 'Tous' ||
          document.category == _selectedCategory;

      final bool matchesSearch =
          _searchQuery.isEmpty ||
          document.title.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
          document.description.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
          document.type.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
          document.variant.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              );

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void didUpdateWidget(covariant DocumentsView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialCategory != oldWidget.initialCategory &&
        _categories.contains(widget.initialCategory)) {
      setState(() {
        _selectedCategory = widget.initialCategory;
        _searchQuery = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DocumentModel> documents = _filteredDocuments;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        title: const Text(
          'Documents',
          style: TextStyle(
            color: Color(0xFF1A1C1C),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Column(
        children: [
          // =========================
          // RECHERCHE
          // =========================
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Rechercher un document...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF767683),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // =========================
          // CATÉGORIES
          // =========================
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final String category = _categories[index];
                final bool selected =
                    category == _selectedCategory;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        _selectedCategory = category;
                        _searchQuery = '';
                      });
                    },
                    selectedColor: const Color(0xFFD3E2ED),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // =========================
          // RÉSULTATS
          // =========================
          Expanded(
            child: documents.isEmpty
                ? const Center(
                    child: Text(
                      'Aucun document trouvé.',
                      style: TextStyle(
                        color: Color(0xFF454652),
                        fontSize: 16,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      0,
                      20,
                      24,
                    ),
                    itemCount: documents.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (context, index) {
                      return _buildDocumentCard(
                        documents[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // =========================
  // CARTE DOCUMENT
  // =========================
  Widget _buildDocumentCard(DocumentModel document) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          _openDocument(document);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFD3E2ED),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIcon(document.icon),
                  color: const Color(0xFF000666),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                document.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1C1C),
                ),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: Text(
                  document.description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xFF454652),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Row(
                children: [
                  Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: Color(0xFF000666),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Voir le document',
                    style: TextStyle(
                      color: Color(0xFF000666),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // OUVERTURE DU DOCUMENT
  // =========================
  void _openDocument(DocumentModel document) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 350,
        ),
        reverseTransitionDuration: const Duration(
          milliseconds: 250,
        ),
        pageBuilder: (
          context,
          animation,
          secondaryAnimation,
        ) {
          return DocumentDetailView(
            document: document,
          );
        },
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          final CurvedAnimation curvedAnimation =
              CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  // =========================
  // ICÔNES
  // =========================
  IconData _getIcon(String icon) {
    switch (icon) {
      case 'stage':
        return Icons.school_outlined;

      case 'motivation':
        return Icons.edit_document;

      case 'emploi':
        return Icons.badge_outlined;

      case 'administration':
        return Icons.account_balance_outlined;

      case 'lettre':
        return Icons.mail_outline;

      case 'attestation':
        return Icons.verified_outlined;

      default:
        return Icons.description_outlined;
    }
  }
}