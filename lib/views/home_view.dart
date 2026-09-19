import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controllers/document_controller.dart';
import '../controllers/home_controller.dart';
import '../models/document_category.dart';
import '../models/document_model.dart';
import 'document_detail_view.dart';
import 'documents_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const Color primaryColor = Color(0xFF000666);
  static const Color backgroundColor = Color(0xFFF9F9F9);
  static const Color secondaryContainer = Color(0xFFD3E2ED);
  static const Color textColor = Color(0xFF1A1C1C);
  static const Color secondaryTextColor = Color(0xFF454652);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = HomeController();
    final DocumentController documentController = DocumentController();

    final List<DocumentCategory> categories =
        homeController.getCategories();

    final List<DocumentModel> popularDocuments =
        documentController.getPopularDocuments();

    final User? user = FirebaseAuth.instance.currentUser;

    final String userName =
        user?.displayName?.trim().isNotEmpty == true
            ? user!.displayName!.trim()
            : 'Utilisateur';

    final String firstLetter =
        userName.isNotEmpty ? userName[0].toUpperCase() : 'U';

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // =========================
            // HEADER
            // =========================
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bienvenue $userName 👋',
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  height: 1.33,
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                'Trouvez rapidement vos documents administratifs',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Avatar
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              firstLetter,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // =========================
                    // RECHERCHE
                    // =========================
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DocumentsView(),
                          ),
                        );
                      },
                      child: Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 16),
                            Icon(
                              Icons.search,
                              size: 32,
                              color: Color(0xFF767683),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Rechercher un document...',
                              style: TextStyle(
                                color: Color(0xFF767683),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =========================
            // DOCUMENTS POPULAIRES
            // =========================
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Documents populaires',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const DocumentsView(),
                                ),
                              );
                            },
                            child: const Text(
                              'Voir tout',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 4),

                    SizedBox(
                      height: 290,
                      child: popularDocuments.isEmpty
                          ? const Center(
                              child: Text(
                                'Aucun document populaire.',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                ),
                              ),
                            )
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              itemCount: popularDocuments.length,
                              separatorBuilder:
                                  (context, index) =>
                                      const SizedBox(width: 16),
                              itemBuilder: (context, index) {
                                final DocumentModel document =
                                    popularDocuments[index];

                                return _buildPopularDocumentCard(
                                  context,
                                  document,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),

            // =========================
            // CATÉGORIES
            // =========================
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Catégories',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 16),

                    GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, index) {
                        final DocumentCategory category =
                            categories[index];

                        return _buildCategoryCard(
                          context,
                          category,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // DOCUMENT POPULAIRE
  // =========================
  Widget _buildPopularDocumentCard(
    BuildContext context,
    DocumentModel document,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        _openDocument(context, document);
      },
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFE8E8E8),
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(document.icon),
                color: secondaryTextColor,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              document.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Text(
                document.description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: secondaryTextColor,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Disponible',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A237E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // CATÉGORIE
  // =========================
  Widget _buildCategoryCard(
    BuildContext context,
    DocumentCategory category,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DocumentsView(
                initialCategory: category.title,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Icon(
                _getIcon(category.icon),
                color: primaryColor,
                size: 32,
              ),

              const SizedBox(height: 8),

              Text(
                category.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // OUVERTURE DOCUMENT
  // =========================
  void _openDocument(
    BuildContext context,
    DocumentModel document,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 350),
        reverseTransitionDuration:
            const Duration(milliseconds: 250),
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

      case 'work':
        return Icons.work_outline;

      case 'school':
        return Icons.school_outlined;

      case 'business':
        return Icons.business_center_outlined;

      case 'description':
        return Icons.description_outlined;

      case 'folder':
        return Icons.folder_open_outlined;

      case 'mail':
        return Icons.mail_outline;

      case 'verified':
        return Icons.verified_outlined;

      default:
        return Icons.description_outlined;
    }
  }
}