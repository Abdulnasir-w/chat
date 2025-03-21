import 'package:chat/core/utils/helpers/snakbar_helper.dart';
import 'package:flutter/material.dart';

extension SnakbarExtension on BuildContext {
  void showErrorSnackbar(String message) {
    SnakbarHelper.showErrorSnakbar(context: this, message: message);
  }

  void showSuccessSnackbar(String message) {
    SnakbarHelper.showSuccessSnakbar(context: this, message: message);
  }

  void showInfoSnackbar(String message) {
    SnakbarHelper.showInfoSnakbar(context: this, message: message);
  }
}
