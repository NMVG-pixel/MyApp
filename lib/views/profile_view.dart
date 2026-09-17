import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Color(0xFF1A1C1C),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Votre profil apparaîtra ici.',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF454652),
          ),
        ),
      ),
    );
  }
}