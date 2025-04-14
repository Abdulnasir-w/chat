import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class AuthTextfield extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType type;
  final TextInputAction action;
  final IconData prefixIcon;
  final bool isPassField;
  final TextCapitalization? capitalization;
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
    this.capitalization,
    this.validator,
  });

  @override
  State<AuthTextfield> createState() => _AuthTextfieldState();
}

class _AuthTextfieldState extends State<AuthTextfield> {
  bool isVisible = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isFocused = _focusNode.hasFocus;

    final OutlineInputBorder baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(
        color: isDarkMode ? context.onSurface : context.primary,
      ),
    );
    return TextFormField(
      focusNode: _focusNode,
      obscureText: widget.isPassField ? isVisible : false,
      controller: widget.controller,
      textCapitalization: widget.capitalization ?? TextCapitalization.none,
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      onTap: () {
        _focusNode.requestFocus();
      },
      keyboardType: widget.type,
      textInputAction: widget.action,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        hintStyle: context.bodyMedium.copyWith(
          color: isFocused ? context.primary : context.onSurface,
        ),
        labelStyle: context.bodyMedium.copyWith(
          color:
              isFocused
                  ? isDarkMode
                      ? context.onSurface
                      : context.primary
                  : context.onSurface,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: isFocused ? context.primary : context.onSurface,
        ),
        suffixIcon:
            widget.isPassField
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: isFocused ? context.primary : context.onSurface,
                  ),
                )
                : null,
        filled: true,
        fillColor: context.surfaceContainerHighest,
        focusedBorder: baseBorder.copyWith(
          borderSide: BorderSide(color: context.primary, width: 1.5),
        ),
        enabledBorder: baseBorder,
        errorBorder: baseBorder.copyWith(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: baseBorder.copyWith(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
      style: context.bodyMedium.copyWith(
        color: isFocused ? context.primary : context.onSurface,
      ), // Text color
      validator: widget.validator,
    );
  }
}
