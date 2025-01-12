import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/appcolors.dart';

class ThemeProvider extends ChangeNotifier {
  // Default theme is light mode
  bool _isDarkMode = false;

  // Color schemes for light and dark modes
  ColorScheme _currentColorScheme = kColorScheme;

  // Getter for current color scheme and dark mode status
  ColorScheme get currentColorScheme => _currentColorScheme;
  bool get isDarkMode => _isDarkMode;

  // Constructor to load saved theme preference
  ThemeProvider() {
    _loadThemePreference();
  }

  // Loads saved theme from SharedPreferences
  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkTheme') ?? false;
    _updateColorScheme();
  }

  // Updates the current color scheme based on theme mode
  void _updateColorScheme() {
    _currentColorScheme = _isDarkMode ? kDarkColorScheme : kColorScheme;
    notifyListeners();  // Notifies listeners to rebuild with the new theme
  }

  // Toggles between dark and light mode and saves the preference
  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _saveThemePreference();
    _updateColorScheme();
  }

  // Saves the selected theme mode to SharedPreferences
  Future<void> _saveThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _isDarkMode);
  }
}