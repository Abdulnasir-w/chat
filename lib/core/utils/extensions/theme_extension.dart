import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get bubbleBackground =>
      Theme.of(this).colorScheme.surfaceContainerHighest;
  Color get messageTextColor => Theme.of(this).colorScheme.onSurface;

  TextStyle get messageTextStyle => Theme.of(
    this,
  ).textTheme.bodyLarge!.copyWith(color: messageTextColor, fontSize: 16);

  TextStyle get timestampStyle => Theme.of(this).textTheme.bodyMedium!.copyWith(
    fontSize: 12,
    color: Theme.of(this).colorScheme.onSurface.withOpacity(0.6),
  );
}
