import 'package:flutter/material.dart';

class TableFilterButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? label;
  final IconData icon;
  final bool isActive;

  const TableFilterButton({
    super.key,
    required this.onTap,
    this.label,
    this.icon = Icons.filter_list,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 36,
        padding: EdgeInsets.symmetric(horizontal: label == null ? 10 : 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.shade50 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? Colors.blue.shade300 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? Colors.blue.shade700 : Colors.grey.shade700,
            ),
            if (label != null) ...[
              const SizedBox(width: 6),
              Text(
                label!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isActive ? Colors.blue.shade700 : Colors.grey.shade800,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
