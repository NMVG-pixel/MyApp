import 'package:flutter/material.dart';

import 'views/main_navigation_view.dart';

import 'views/splash_view.dart';

void main() {
  runApp(const DocsAdminsApp());
}

class DocsAdminsApp extends StatelessWidget {
  const DocsAdminsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Docs Admins',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}