import 'package:flutter/material.dart';

ThemeData buildTheme(Brightness brightness) {
  final base = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF605BFF),
    brightness: brightness,
  );
  return base.copyWith(
    textTheme: base.textTheme.copyWith(
      displayLarge: const TextStyle(fontWeight: FontWeight.w800),
      displayMedium: const TextStyle(fontWeight: FontWeight.w800),
      displaySmall: const TextStyle(fontWeight: FontWeight.w800),
      headlineMedium: const TextStyle(fontWeight: FontWeight.w700),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: brightness == Brightness.light ? Colors.white : const Color(0xFF121212),
      shadowColor: Colors.black12,
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
    ),
  );
}