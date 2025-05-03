import 'package:flutter/material.dart';
import 'screens/authentication/welcome_screen.dart';
import 'screens/diet_selection_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
