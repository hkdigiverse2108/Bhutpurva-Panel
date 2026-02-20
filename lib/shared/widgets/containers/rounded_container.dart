import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.child,
    this.radius = SizeConst.cardRadiusLg,
    this.width,
    this.height,
    this.showBorder = false,
    this.showShadow = true,
    this.backgroundColor = ColorConst.white,
    this.borderColor = ColorConst.borderPrimary,
    this.margin,
    this.padding = const EdgeInsets.all(SizeConst.md),
    this.onTap,
  });

  final Widget? child;
  final double radius;
  final double? width;
  final double? height;
  final bool showBorder;
  final bool showShadow;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: child,
      ),
    );
  }
}
