import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.light,
    ),
    fontFamily: 'Vazirmatn',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(height: 1.6),
      bodyMedium: TextStyle(height: 1.6),
      titleLarge: TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.dark,
    ),
    fontFamily: 'Vazirmatn',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(height: 1.6),
      bodyMedium: TextStyle(height: 1.6),
      titleLarge: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
