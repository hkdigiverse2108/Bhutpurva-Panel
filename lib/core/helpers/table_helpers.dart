import 'package:flutter/material.dart';

class TableHelpers {
  const TableHelpers._();

  static WidgetStateProperty<Color?> rowHoverColor({Color? hoverColor}) {
    return WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.hovered)) {
        return hoverColor ?? Colors.grey.shade50;
      }
      return null;
    });
  }
}
