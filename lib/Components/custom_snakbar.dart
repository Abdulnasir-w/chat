import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle),
                  child: Center(
                    child: Lottie.asset(
                      "assets/error.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
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
