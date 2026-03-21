import 'package:flutter/material.dart';

class AppTableColumn {
  final String title;
  final double? width;
  final bool sortable;
  final TextAlign? textAlign;

  const AppTableColumn({
    required this.title,
    this.width,
    this.sortable = false,
    this.textAlign,
  });
}
