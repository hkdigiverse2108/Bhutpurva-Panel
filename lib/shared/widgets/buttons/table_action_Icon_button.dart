import 'package:flutter/material.dart';

Widget tableActionIconButton({
  required IconData icon,
  required VoidCallback onTap,
  Color color = Colors.black87,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(8),
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Icon(icon, size: 18, color: color),
    ),
  );
}
