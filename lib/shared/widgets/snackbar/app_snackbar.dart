import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'app_snackbar_style.dart';

class AppSnackBar {
  static void show({
    required String title,
    required String message,
    AppSnackBarType type = AppSnackBarType.info,
    int duration = 3,
    bool dismissible = true,
  }) {
    final style = AppSnackBarStyle.fromType(type);

    Get.snackbar(
      "",
      "",
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      maxWidth: 520,
      duration: Duration(seconds: duration),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      messageText: _AdminSnackContent(
        title: title,
        message: message,
        icon: Iconsax.tick_circle,
        accentColor: style.iconColor,
      ),
    );
  }
}

class _AdminSnackContent extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color accentColor;

  const _AdminSnackContent({
    required this.title,
    required this.message,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 4,
            height: 42,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: accentColor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (message.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
