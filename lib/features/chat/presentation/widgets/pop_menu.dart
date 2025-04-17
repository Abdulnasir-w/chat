import 'package:flutter/material.dart';

PopupMenuItem menu({required String title, required VoidCallback onPressed}) {
  return PopupMenuItem(
    value: title,
    child: TextButton(onPressed: onPressed, child: Text(title)),
  );
}
