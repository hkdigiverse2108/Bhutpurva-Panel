import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:flutter/material.dart';

class AdminFormButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final AdminButtonVariant variant;

  const AdminFormButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.variant = AdminButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = onPressed == null || isLoading;
    final Color effectiveColor = _getVariantColor(context);
    final bool isGhost = variant == AdminButtonVariant.ghost;
    final bool isSecondary = variant == AdminButtonVariant.secondary;

    return UnconstrainedBox(
      alignment: Alignment.centerLeft,
      child: Material(
        color: disabled
            ? Colors.grey.shade200
            : (isGhost ? Colors.transparent : effectiveColor),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: disabled ? null : onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: isSecondary
                  ? Border.all(color: Colors.grey.shade300)
                  : (isGhost
                        ? Border.all(
                            color: effectiveColor.withValues(alpha: 0.3),
                          )
                        : null),
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            size: 16,
                            color: isGhost || isSecondary
                                ? Colors.black
                                : Colors.white,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          label,
                          style: TextStyle(
                            color: isGhost || isSecondary
                                ? Colors.black
                                : Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getVariantColor(BuildContext context) {
    switch (variant) {
      case AdminButtonVariant.primary:
        return Theme.of(context).primaryColor;
      case AdminButtonVariant.secondary:
        return Colors.grey.shade100;
      case AdminButtonVariant.danger:
        return Colors.red.shade600;
      case AdminButtonVariant.ghost:
        return Theme.of(context).primaryColor;
    }
  }
}
