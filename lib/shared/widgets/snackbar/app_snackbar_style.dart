import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:flutter/material.dart';

class AppSnackBarStyle {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;

  const AppSnackBarStyle({
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
  });

  static AppSnackBarStyle fromType(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return const AppSnackBarStyle(
          backgroundColor: Color(0xFFEFFAF3),
          iconColor: Color(0xFF12B76A),
          icon: Icons.check_circle_rounded,
        );
      case AppSnackBarType.error:
        return const AppSnackBarStyle(
          backgroundColor: Color(0xFFFFF1F3),
          iconColor: Color(0xFFF04438),
          icon: Icons.error_rounded,
        );
      case AppSnackBarType.warning:
        return const AppSnackBarStyle(
          backgroundColor: Color(0xFFFFF8EB),
          iconColor: Color(0xFFF79009),
          icon: Icons.warning_amber_rounded,
        );
      case AppSnackBarType.info:
        return const AppSnackBarStyle(
          backgroundColor: Color(0xFFEFF8FF),
          iconColor: Color(0xFF2E90FA),
          icon: Icons.info_rounded,
        );
    }
  }
}
