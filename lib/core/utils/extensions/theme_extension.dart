import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color get primary => Theme.of(this).colorScheme.primary;
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get surfaceContainerHighest =>
      Theme.of(this).colorScheme.surfaceContainerHighest; //bubbleBackground
  Color get onSurface =>
      Theme.of(this).colorScheme.onSurface; //messageTextColor
  Color get surface => Theme.of(this).colorScheme.surface;

  TextStyle get messageTextStyle => Theme.of(
    this,
  ).textTheme.bodyLarge!.copyWith(color: onSurface, fontSize: 16);

  TextStyle get timestampStyle => Theme.of(this).textTheme.bodyMedium!.copyWith(
    fontSize: 12,
    color: Theme.of(this).colorScheme.onSurface.withValues(alpha: 0.9),
  );

  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!.copyWith(
    fontWeight: FontWeight.w700,
    fontFamily: "Poppins",
    fontSize: 17,
    color: Colors.white,
  );
  TextStyle get headlineMedium =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(
        color: Theme.of(this).colorScheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 45,
      );
}
