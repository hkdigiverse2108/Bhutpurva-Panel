import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:flutter/material.dart';

class TableFilterField extends StatelessWidget {
  final String label;
  final String hint;
  final List<AdminDropdownItem<dynamic>> items; // Add this line
  final Function(String) onChanged;
  final String? value;

  const TableFilterField({
    super.key,
    required this.label,
    required this.hint,
    required this.items, // Add this to constructor
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AdminSearchSelectField(
      outSide: true,
      label: label,
      hint: hint,
      items: items,
      value: value,
      onChanged: (value) => onChanged(value?.toString() ?? ''),
    );
  }
}
