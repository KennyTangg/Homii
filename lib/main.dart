import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homii/screens/authentication/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:homii/theme/theme_provider.dart';
import 'package:homii/models/meal_plan_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MealPlanModel()),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode, 
        builder: (context) => const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
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
          outline: Color(0xFF111827),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF1F2937),
          onSurface: Color(0xFFE5E7EB),
          primary: Color.fromRGBO(100, 150, 97, 1),
          onPrimary: Color(0xFF111827),
          secondary: Color.fromRGBO(255, 128, 64, 1),
          onSecondary: Color.fromRGBO(246, 184, 226, 1),
          tertiary: Color.fromRGBO(255, 215, 64, 1),
          error: Colors.red,
          outline: Color(0xFF9CA3AF),
        ),
      ),
      themeMode: themeProvider.themeMode,
      home: const SplashScreen(),
    );
  }
}
