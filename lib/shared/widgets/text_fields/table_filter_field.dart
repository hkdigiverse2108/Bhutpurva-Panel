import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:flutter/material.dart';

class TableFilterField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final List<AdminDropdownItem<T>> items;
  final Function(T?) onChanged;
  final T? value;

  const TableFilterField({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AdminSearchSelectField<T>(
      outSide: true,
      label: label,
      hint: hint,
      items: items,
      value: value,
      onChanged: onChanged,
    );
  }
}
