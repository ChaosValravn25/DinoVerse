import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF4CAF50), // verde
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFA5D6A7),
  onPrimaryContainer: Color(0xFF1B5E20),
  secondary: Color(0xFFCDDC39),
  onSecondary: Color(0xFF000000),
  secondaryContainer: Color(0xFFF0F4C3),
  onSecondaryContainer: Color(0xFF827717),
  error: Color(0xFFB00020),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFCD8DF),
  onErrorContainer: Color(0xFF370617),
  surface: Color(0xFFFFFFFF), // reemplaza background
  onSurface: Color(0xFF000000), // reemplaza onBackground
  surfaceTint: Color(0xFF4CAF50),
  outline: Color(0xFF757575),
  shadow: Color(0xFF000000),
  inverseSurface: Color(0xFF303030),
  onInverseSurface: Color(0xFFFFFFFF),
  inversePrimary: Color(0xFF81C784),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF81C784),
  onPrimary: Color(0xFF003300),
  primaryContainer: Color(0xFF388E3C),
  onPrimaryContainer: Color(0xFFC8E6C9),
  secondary: Color(0xFFC0CA33),
  onSecondary: Color(0xFF212121),
  secondaryContainer: Color(0xFF827717),
  onSecondaryContainer: Color(0xFFF0F4C3),
  error: Color(0xFFEF9A9A),
  onError: Color(0xFFB71C1C),
  errorContainer: Color(0xFFD32F2F),
  onErrorContainer: Color(0xFFFFEBEE),
  surface: Color(0xFF121212),
  onSurface: Color(0xFFE0E0E0),
  surfaceTint: Color(0xFF81C784),
  outline: Color(0xFFBDBDBD),
  shadow: Color(0xFF000000),
  inverseSurface: Color(0xFFE0E0E0),
  onInverseSurface: Color(0xFF121212),
  inversePrimary: Color(0xFFA5D6A7),
);
