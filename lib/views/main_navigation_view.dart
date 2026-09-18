import 'package:flutter/material.dart';

import '../controllers/main_navigation_controller.dart';
import 'documents_view.dart';
import 'history_view.dart';
import 'home_view.dart';
import 'profile_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() =>
      _MainNavigationViewState();
}

class _MainNavigationViewState
    extends State<MainNavigationView> {
  final MainNavigationController _controller =
      MainNavigationController();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = const [
      HomeView(),
      DocumentsView(),
      HistoryView(),
      ProfileView(),
    ];
  }

  void _onNavigationItemSelected(int index) {
    setState(() {
      _controller.changePage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _controller.currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000666).withValues(
                  alpha: 0.15,
                ),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavigationItem(
                icon: Icons.home,
                label: 'Accueil',
                index: 0,
              ),
              _buildNavigationItem(
                icon: Icons.description_outlined,
                label: 'Documents',
                index: 1,
              ),
              _buildNavigationItem(
                icon: Icons.history,
                label: 'Historique',
                index: 2,
              ),
              _buildNavigationItem(
                icon: Icons.person_outline,
                label: 'Profil',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool active = _controller.currentIndex == index;

    return GestureDetector(
      onTap: () => _onNavigationItemSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFD3E2ED)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: active
                  ? const Color(0xFF1A237E)
                  : const Color(0xFFC6C5D4),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: active
                    ? const Color(0xFF1A237E)
                    : const Color(0xFFC6C5D4),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}