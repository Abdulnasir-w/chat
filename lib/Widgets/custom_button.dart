import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: SvgPicture.asset(
              "assets/whatsapp.svg",
              width: 40,
              height: 40,
            )),
        Text(title),
      ],
    );
  }
}
