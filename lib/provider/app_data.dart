import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_laboratorio_3/pages/api.dart';
import 'package:flutter_application_laboratorio_3/pages/models/dinosaur.dart';

class AppData extends ChangeNotifier {
  int _counter = 0;
  String _username = "Guest";
  bool _resetEnabled = true;
  bool _darkMode = false;
  String _selectedDinoImage = ''; // Foto de perfil
  String _dinoImage = ''; // Imagen del dinosaurio para bienvenida
  String _filterCriteria = 'diet'; // 'diet' o 'period'
  String _filterValue = ''; // Valor seleccionado (ej. 'carnivore', 'Cretaceous')
  List<Dinosaur> _filteredDinosaurs = []; // Lista de dinosaurios filtrados
  List<Dinosaur> _selectedDinosaurs = []; // Tres dinosaurios seleccionados

  int get counter => _counter;
  String get username => _username;
  bool get resetEnabled => _resetEnabled;
  bool get darkMode => _darkMode;
  String get selectedDinoImage => _selectedDinoImage;
  String get dinoImage => _dinoImage;
  String get filterCriteria => _filterCriteria;
  String get filterValue => _filterValue;
  List<Dinosaur> get filteredDinosaurs => _filteredDinosaurs;
  List<Dinosaur> get selectedDinosaurs => _selectedDinosaurs;

  AppData() {
    _loadPreferences();
    _fetchAndFilterDinosaurs();
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

  void setSelectedDinoImage(String value) {
    _selectedDinoImage = value;
    _savePreferences();
    notifyListeners();
  }

  void setDinoImage(String value) {
    _dinoImage = value;
    _savePreferences();
    notifyListeners();
  }

  void setFilterCriteria(String criteria) {
    _filterCriteria = criteria;
    _fetchAndFilterDinosaurs();
    notifyListeners();
  }

  void setFilterValue(String value) {
    _filterValue = value;
    _fetchAndFilterDinosaurs();
    notifyListeners();
  }

  void setSelectedDinosaurs(List<Dinosaur> dinos) {
    _selectedDinosaurs = dinos.take(3).toList();
    _savePreferences();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? "Guest";
    _darkMode = prefs.getBool('darkMode') ?? false;
    _selectedDinoImage = prefs.getString('selectedDinoImage') ?? '';
    _dinoImage = prefs.getString('dinoImage') ?? '';
    _filterCriteria = prefs.getString('filterCriteria') ?? 'diet';
    _filterValue = prefs.getString('filterValue') ?? '';
    // Cargar selectedDinosaurs no implementado aquí por simplicidad, se manejará manualmente
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _username);
    await prefs.setBool('darkMode', _darkMode);
    await prefs.setString('selectedDinoImage', _selectedDinoImage);
    await prefs.setString('dinoImage', _dinoImage);
    await prefs.setString('filterCriteria', _filterCriteria);
    await prefs.setString('filterValue', _filterValue);
    // Guardar selectedDinosaurs no implementado aquí por simplicidad
  }

  Future<void> _fetchAndFilterDinosaurs() async {
    final allDinosaurs = await DinosaurService().fetchDinosaurs();
    _filteredDinosaurs = allDinosaurs.where((dino) {
      if (_filterCriteria == 'diet') return dino.diet.toLowerCase() == _filterValue.toLowerCase();
      if (_filterCriteria == 'period') return dino.period.toLowerCase() == _filterValue.toLowerCase();
      return false;
    }).toList();
    notifyListeners();
  }
}