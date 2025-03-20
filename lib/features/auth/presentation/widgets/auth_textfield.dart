import 'package:flutter/material.dart';

class AuthTextfield extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType type;
  final TextInputAction action;
  final IconData prefixIcon;
  final bool isPassField;
  final String? Function(String?)? validator;

  const AuthTextfield({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.type,
    required this.action,
    required this.prefixIcon,
    this.isPassField = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(color: Colors.black),
    );
    return TextFormField(
      controller: controller,
      keyboardType: type,
      textInputAction: action,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(prefixIcon),

        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        enabledBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.black),
        ),
        errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
      validator: validator,
    );
  }
}
