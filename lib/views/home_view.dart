import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import '../models/document_category.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const Color primaryColor = Color(0xFF000666);
  static const Color backgroundColor = Color(0xFFF9F9F9);
  static const Color secondaryContainer = Color(0xFFD3E2ED);
  static const Color textColor = Color(0xFF1A1C1C);
  static const Color secondaryTextColor = Color(0xFF454652);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = HomeController();
    final List<DocumentCategory> categories = controller.getCategories();

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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Bienvenue dans votre\napplication Jean',
                                style: TextStyle(
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
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: secondaryTextColor,
                            size: 28,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // =========================
                    // RECHERCHE
                    // =========================
                    Container(
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
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Rechercher un document...',
                          hintStyle: TextStyle(
                            color: Color(0xFF767683),
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 32,
                            color: Color(0xFF767683),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 8,
                          ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                              // Navigation vers le catalogue à venir.
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
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _buildPopularDocumentCard(
                            icon: Icons.work_outline,
                            title: 'Demande de stage',
                            description:
                                'Modèle standard pour postuler à une offre de stage professionnel.',
                          ),
                          const SizedBox(width: 16),
                          _buildPopularDocumentCard(
                            icon: Icons.edit_document,
                            title: 'Lettre de motivation',
                            description:
                                'Structure professionnelle pour accompagner votre CV.',
                          ),
                          const SizedBox(width: 16),
                          _buildPopularDocumentCard(
                            icon: Icons.badge_outlined,
                            title: 'Demande d’emploi',
                            description:
                                'Format officiel pour une candidature spontanée.',
                          ),
                        ],
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
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, index) {
                        return _buildCategoryCard(
                          categories[index],
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

  Widget _buildPopularDocumentCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            maxLines: 1,
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
              description,
              maxLines: 3,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Icons.download,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(DocumentCategory category) {
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
          // Navigation vers les documents de la catégorie à venir.
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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

  IconData _getIcon(String icon) {
    switch (icon) {
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

      case 'administration':
        return Icons.account_balance_outlined;

      case 'mail':
        return Icons.mail_outline;

      case 'verified':
        return Icons.verified_outlined;

      default:
        return Icons.description_outlined;
    }
  }
}