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
      backgroundColor: Colors.greenAccent,
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
      backgroundColor: Colors.red,
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
      backgroundColor: Colors.lightBlue,
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
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snakbar);
  }
}
