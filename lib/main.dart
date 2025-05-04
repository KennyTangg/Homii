import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homii/screens/authentication/splash_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, 
      builder: (context) => const MainApp(),
    ),
  );
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
          surface: Color.fromRGBO(247, 244, 237, 1),
          onSurface: Colors.black,
          primary: Color.fromRGBO(69, 121, 66, 1),
          onPrimary: Colors.white,
          secondary: Color.fromRGBO(223, 103, 48, 1),
          onSecondary: Color.fromRGBO(246, 184, 226, 1),
          tertiary: Color.fromRGBO(255, 200, 36, 1),
          error: Colors.red,
          outline: Color(0xFF424242),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
