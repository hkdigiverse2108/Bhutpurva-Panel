import 'package:flutter/material.dart';

class TableSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final void Function(String value)? onSearchChanged;

  const TableSearchField({
    super.key,
    required this.controller,
    this.hint = 'Search...',
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search, size: 18),
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: onSearchChanged,
    );
  }
}
