import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum SnackbarType { success, error, warnning }

class CustomSnackbar extends StatelessWidget {
  final String message;
  final Alignment alignment;
  final SnackbarType type;

  const CustomSnackbar({
    super.key,
    required this.message,
    required this.alignment,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    String animationPath;
    Color? color;
    switch (type) {
      case SnackbarType.success:
        animationPath = 'assets/success.json';
        color = Colors.green;
        break;
      case SnackbarType.error:
        animationPath = 'assets/error.json';
        color = Colors.red;
        break;
      case SnackbarType.warnning:
        animationPath = 'assets/warning.json';
        color = const Color(0xffffb700);
        break;
      default:
        animationPath =
            'assets/default0.json'; // Add a default animation if needed
    }
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
              color: color,
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
                  child: Lottie.asset(
                    animationPath,
                    fit: BoxFit.scaleDown,
                    backgroundLoading: true,
                    alignment: Alignment.center,
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
    required Alignment alignment,
    required SnackbarType type,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => CustomSnackbar(
        message: message,
        alignment: alignment,
        type: type,
      ),
    );

    // Insert the overlay entry into the overlay
    overlay.insert(overlayEntry);

    // Remove the overlay entry after a duration
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
