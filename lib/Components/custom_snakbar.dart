import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;
  final Color? backgroundColor;
  final Alignment alignment;

  const CustomSnackbar({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: alignment,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 350,
            height: 70,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 104, height: 50, child: Text("")),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void showCustomSnackbar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required Alignment alignment,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => CustomSnackbar(
        message: message,
        backgroundColor: backgroundColor,
        alignment: alignment,
      ),
    );

    // Insert the overlay entry into the overlay
    overlay.insert(overlayEntry);

    // Remove the overlay entry after a duration
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
