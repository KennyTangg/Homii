import 'package:flutter/material.dart';
import 'package:homii/screens/authentication/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homii',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          surface: Colors.white,
          onSurface: Colors.black,
          primary: Color.fromRGBO(69, 121, 66, 1),
          onPrimary: Colors.white,
          secondary: Color.fromRGBO(223, 103, 48, 1),
          onSecondary: Colors.white,
          tertiary: Color.fromRGBO(255, 200, 36, 1),
          error: Colors.red,
          outline: Color(0xFF424242),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
