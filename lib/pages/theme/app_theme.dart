import 'package:flutter/material.dart';
import 'color_schemes.g.dart'; // Tu archivo generado desde Theme Builder

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Lato',
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Lato',
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
  ),
);

