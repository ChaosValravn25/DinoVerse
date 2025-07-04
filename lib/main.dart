import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart'; // Necesario para Provider
import 'pages/theme/app_theme.dart'; // Asegúrate de que exista este archivo
import 'provider/app_data.dart'; // Corrección del import
import 'pages/splash_screen.dart';

void main() {
  var logger = Logger();
  logger.d("Logger iniciado correctamente");

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppData(),
      child: const DinoVerseApp(),
    ),
  );
}

class DinoVerseApp extends StatelessWidget {
  const DinoVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);

    return MaterialApp(
      title: 'DinoVerse',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: appData.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
