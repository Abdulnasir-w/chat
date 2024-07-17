import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String asset;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            asset,
            width: 40,
            height: 40,
          ),
        ),
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "Roboto",
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
