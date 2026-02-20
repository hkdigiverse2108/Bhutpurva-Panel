import 'package:flutter/material.dart';

Widget tableActionTextButton({
  required String text,
  required VoidCallback onTap,
  Color backgroundColor = const Color(0xFFE3F2FD),
  Color textColor = const Color(0xFF1565C0),
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(8),
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    ),
  );
}
