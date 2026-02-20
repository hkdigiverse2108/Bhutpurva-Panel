import 'package:flutter/material.dart';

class AdminTableFilter extends StatelessWidget {
  final List<Widget> children;

  const AdminTableFilter({super.key, required this.children});

  int _columns(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filters', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = _columns(constraints.maxWidth);
              final spacing = 10.0;

              final itemWidth =
                  (constraints.maxWidth - (spacing * (cols - 1))) / cols;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: children
                    .map((child) => SizedBox(width: itemWidth, child: child))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
