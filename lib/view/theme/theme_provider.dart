import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    final String? mode = await storage.read(key: 'theme');
    _themeMode = mode == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void saveTheme(String mode) async {
    _themeMode = mode == 'dark' ? ThemeMode.dark : ThemeMode.light;
    await storage.write(key: 'theme', value: mode);
    notifyListeners();
  }
}
