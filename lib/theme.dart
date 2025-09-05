import 'package:flutter/material.dart';

/// Builds the app's theme based on the given brightness (light or dark).
ThemeData buildTheme(Brightness brightness) {
  // Create the base theme using Material 3, a color seed, and the specified brightness.
  final base = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF605BFF),
    brightness: brightness,
  );

  return base.copyWith(
    // Customize the text theme with specific font weights for headings.
    textTheme: base.textTheme.copyWith(
      displayLarge: const TextStyle(fontWeight: FontWeight.w800),
      displayMedium: const TextStyle(fontWeight: FontWeight.w800),
      displaySmall: const TextStyle(fontWeight: FontWeight.w800),
      headlineMedium: const TextStyle(fontWeight: FontWeight.w700),
    ),
    // Define the card appearance: elevation, shape, color, shadow, and margin.
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF121212),
      shadowColor: Colors.black12,
      margin: EdgeInsets.zero,
    ),
    // Set the default input decoration with rounded borders.
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
    ),
  );
}
