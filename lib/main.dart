import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'pages/diet_selection_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homii',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      // Start with the welcome page
      home: const WelcomePage(),
    );
  }
}
