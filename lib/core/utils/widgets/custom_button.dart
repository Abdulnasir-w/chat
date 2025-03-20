import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final AsyncValue<void> state;
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: state.isLoading ? null : onPressed,
      child:
          state.isLoading
              ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              )
              : Text(title),
    );
  }
}
