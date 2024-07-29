import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4A90E2);
  static const Color accentColor = Color(0xFF50E3C2);
  static const Color backgroundColor = Color(0xffF5F7FA);
  static const Color textColor = Color(0xFF4A4A4A);
  static const Color secondaryTextColor = Color(0xFF9B9B9B);
  static const Color errorColor = Color(0xFFD0021B);

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary:
            primaryColor, // using for pp bars, buttons, and other elements you want to stand out.
        secondary:
            accentColor, //   Use this for highlights, active states, and interactive elements.
        surface: backgroundColor, // primary background color of your app,
        onPrimary: textColor, // main text color for readability.
        onSurface:
            secondaryTextColor, // econdary information or less important text.
        onError: errorColor,
        // error messages and indicators.
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        color: primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: secondaryTextColor),
      ),
    );
  }
}
