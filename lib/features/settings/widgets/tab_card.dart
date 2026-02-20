import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:flutter/material.dart';

class TabCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const TabCard({
    super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: !isSelected
              ? ColorConst.grey.withValues(alpha: 0.2)
              : ColorConst.primary.withValues(alpha: 0.8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            color: !isSelected ? ColorConst.black : Colors.white,
            // fontSize: 12,
          ),
        ),
      ),
    );
  }
}
