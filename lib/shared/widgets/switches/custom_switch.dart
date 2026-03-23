import 'package:flutter/material.dart';
import 'package:bhutpurva_penal/core/constants/color_const.dart';

/// A premium, custom switch widget for the Bhutpurva Panel.
/// Features smooth animations, custom colors, and a refined aesthetic.
class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final double width;
  final double height;
  final double thumbSize;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.width = 44.0,
    this.height = 24.0,
    this.thumbSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? ColorConst.primary;
    final effectiveInactiveColor =
        inactiveColor ?? ColorConst.grey.withAlpha(50);
    final effectiveThumbColor = thumbColor ?? Colors.white;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
          color: value ? effectiveActiveColor : effectiveInactiveColor,
          border: Border.all(
            color: value ? effectiveActiveColor : ColorConst.grey.withAlpha(80),
            width: 1.0,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: thumbSize,
            height: thumbSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: effectiveThumbColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
