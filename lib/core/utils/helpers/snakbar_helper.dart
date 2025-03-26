import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scaffoldMessengerKeyProvider =
    Provider<GlobalKey<ScaffoldMessengerState>>((ref) {
      return GlobalKey<ScaffoldMessengerState>();
    });

class SnakbarHelper {
  static void showSuccessSnakbar({
    required BuildContext context,
    required String message,
  }) {
    _showBaseSnakbar(
      context: context,
      message: message,
      backgroundColor: const Color.fromARGB(255, 108, 234, 173),
      textColor: Colors.white,
    );
  }

  static void showErrorSnakbar({
    required BuildContext context,
    required String message,
  }) {
    _showBaseSnakbar(
      context: context,
      message: message,
      backgroundColor: const Color.fromARGB(255, 219, 112, 105),
      textColor: Colors.white,
    );
  }

  static void showInfoSnakbar({
    required BuildContext context,
    required String message,
  }) {
    _showBaseSnakbar(
      context: context,
      message: message,
      backgroundColor: const Color.fromARGB(255, 109, 199, 241),
      textColor: Colors.white,
    );
  }

  static void _showBaseSnakbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Color textColor,
  }) {
    final snakbar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      dismissDirection: DismissDirection.up,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snakbar);
  }
}
