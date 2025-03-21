import 'package:flutter/material.dart';

class AuthTextfield extends StatefulWidget {
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
      setState(() {}); // Trigger rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isFocused = _focusNode.hasFocus;

    final OutlineInputBorder baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(
        color: isDarkMode ? colorScheme.onSurface : colorScheme.primary,
      ),
    );
    return TextFormField(
      focusNode: _focusNode,
      obscureText: widget.isPassField ? isVisible : false,
      controller: widget.controller,
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      keyboardType: widget.type,
      textInputAction: widget.action,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: isFocused ? colorScheme.primary : colorScheme.onSurface,
        ),
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color:
              isFocused
                  ? isDarkMode
                      ? colorScheme.onSurface
                      : colorScheme.primary
                  : colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: isFocused ? colorScheme.primary : colorScheme.onSurface,
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
                    color:
                        isFocused ? colorScheme.primary : colorScheme.onSurface,
                  ),
                )
                : null,
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        focusedBorder: baseBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        enabledBorder: baseBorder,
        errorBorder: baseBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: baseBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: colorScheme.primary,
      ), // Text color
      validator: widget.validator,
    );
  }
}
