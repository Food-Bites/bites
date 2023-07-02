import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType {
  system,
  light,
  dark,
}

/// The [ThemeProvider] class is a utility class to provide the value of the themeMode variable.
/// {@category Utilities}
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeType _themeType = ThemeType.system;

  ThemeMode get themeMode => _themeMode;
  ThemeType get themeType => _themeType;

  void loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeTypeIndex = prefs.getInt('themeType');
    if (themeTypeIndex == null) {
      _themeMode = ThemeMode.system;
      _themeType = ThemeType.system;
    } else {
      _themeType = ThemeType.values[themeTypeIndex];
      _themeMode = _themeTypeToThemeMode(_themeType);
    }
    notifyListeners();
  }

  void setThemeType(ThemeType themeType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeType', themeType.index);
    _themeType = themeType;
    _themeMode = _themeTypeToThemeMode(themeType);
    notifyListeners();
  }

  ThemeMode _themeTypeToThemeMode(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.system:
        return ThemeMode.system;
      case ThemeType.light:
        return ThemeMode.light;
      case ThemeType.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
