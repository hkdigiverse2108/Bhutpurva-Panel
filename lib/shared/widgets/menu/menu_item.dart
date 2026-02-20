import 'package:flutter/material.dart';

class OverlayMenuItem<T> extends StatelessWidget {
  final String label;
  final T value;
  final T? selectedValue;
  final void Function(T value) onSelected;

  const OverlayMenuItem({
    super.key,
    required this.label,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
  });

  bool get isSelected => value == selectedValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (isSelected)
              const Icon(Icons.check, size: 16)
            else
              const SizedBox(width: 16),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
