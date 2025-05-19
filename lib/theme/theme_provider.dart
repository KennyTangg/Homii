import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  
  ThemeMode get themeMode => _themeMode;
  
  ThemeProvider() {
    _loadThemeMode();
  }
  
  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeIndex = prefs.getInt('theme_mode') ?? 1; // Default to 1 (light mode)
      _themeMode = ThemeMode.values[themeModeIndex];
      notifyListeners();
    } catch (e) {
      // Fallback to light mode if there's an error
      _themeMode = ThemeMode.light;
    }
  }
  
  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return; // Skip if already in this mode
    
    _themeMode = mode;
    
    // Notify listeners immediately
    notifyListeners();
    
    // Save preference in the background
    Future(() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('theme_mode', mode.index);
      } catch (e) {
        // Silently handle errors
      }
    });
  }
}




