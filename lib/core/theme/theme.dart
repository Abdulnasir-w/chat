import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Color(0xFF3F51B5), // Indigo Blue
      brightness: Brightness.light,
      primary: Color(0xFF3F51B5), // Indigo Blue
      secondary: Color(0xFFFF6F61), // Coral
      surface: Color(0xFFF5F5F5), // Soft Cream
      onSurface: Color(0xFF333333), // Charcoal
      surfaceContainerHighest: Color(
        0xFFE3F2FD,
      ), // Light Blue-Gray for receiver bubbles
    );

    return ThemeData(
      useMaterial3: true, // Enable Material 3
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0, // M3 prefers flat app bars
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: colorScheme.onPrimary,
        ),
      ),
      textTheme: Typography.material2021().black
          .apply(fontFamily: 'Poppins')
          .copyWith(
            bodyLarge: TextStyle(color: colorScheme.onSurface, fontSize: 16),
            bodyMedium: TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
            ), // Slate Gray
            titleLarge: TextStyle(fontWeight: FontWeight.bold),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ), // M3 rounded corners
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: colorScheme.surfaceContainer, // Slightly elevated surface
        elevation: 1, // M3 uses subtle elevation
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static ThemeData darkTheme() {
    // Generate a color scheme from the primary Indigo Blue seed
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Color(0xFF3F51B5), // Indigo Blue
      brightness: Brightness.dark,
      primary: Color(0xFF3F51B5), // Indigo Blue
      secondary: Color(0xFFFF8A65), // Peach
      surface: Color(0xFF1A1A1A), // Deep Charcoal
      onSurface: Color(0xFFF0F0F0), // Off-White
      surfaceContainerHighest: Color(
        0xFF37474F,
      ), // Dark Blue-Gray for receiver bubbles
    );

    return ThemeData(
      useMaterial3: true, // Enable Material 3
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: colorScheme.onPrimary,
        ),
      ),
      textTheme: Typography.material2021().white
          .apply(fontFamily: 'Poppins')
          .copyWith(
            bodyLarge: TextStyle(color: colorScheme.onSurface, fontSize: 16),
            bodyMedium: TextStyle(
              color: Color(0xFFA0A0A0),
              fontSize: 14,
            ), // Light Gray
            titleLarge: TextStyle(fontWeight: FontWeight.bold),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: colorScheme.surfaceContainer,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
