import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends ChangeNotifier {
  int _counter = 0;
  String _username = "Invitado";
  bool _resetEnabled = true;
  bool _darkMode = false;

  int get counter => _counter;
  String get username => _username;
  bool get resetEnabled => _resetEnabled;
  bool get darkMode => _darkMode;

  AppData() {
    _loadPreferences();
  }

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }

  void reset() {
    if (_resetEnabled) {
      _counter = 0;
      notifyListeners();
    }
  }

  void setUsername(String name) {
    _username = name;
    _savePreferences();
    notifyListeners();
  }

  void toggleReset(bool value) {
    _resetEnabled = value;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _darkMode = value;
    _savePreferences();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? "Invitado";
    _darkMode = prefs.getBool('darkMode') ?? false;
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _username);
    await prefs.setBool('darkMode', _darkMode);
  }
}
