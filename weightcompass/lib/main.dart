import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Global colors
  static const Color backgroundColor = Color(0xFFF0F9FF);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
      ),
    );
  }
}