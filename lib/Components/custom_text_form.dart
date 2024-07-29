import 'package:flutter/material.dart';

class MyCustomTextFormField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final TextInputType keyBoardType;
  final String? Function(String?)? validator;
  final bool isPassField;

  const MyCustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.keyBoardType,
    this.validator,
    this.controller,
    required this.prefixIcon,
    this.isPassField = false,
  });

  @override
  State<MyCustomTextFormField> createState() => _MyCustomTextFormFieldState();
}

class _MyCustomTextFormFieldState extends State<MyCustomTextFormField> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassField ? isVisible : false,
      keyboardType: widget.keyBoardType,
      decoration: InputDecoration(
        label: Text(
          widget.label,
          style: const TextStyle(color: Colors.black),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Color(0xFF4A90E2)),
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: widget.isPassField
            ? IconButton(
                onPressed: () {
                  isVisible = !isVisible;
                },
                icon: Icon(
                  isVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: widget.validator,
    );
  }
}
