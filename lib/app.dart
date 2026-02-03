import 'package:flutter/material.dart';
import 'shared/navigation/main_navigation_shell.dart';

class FinLearnApp extends StatelessWidget {
  const FinLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finlearn Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B4EF5)),
        useMaterial3: true,
      ),
      home: const MainNavigationShell(),
    );
  }
}
