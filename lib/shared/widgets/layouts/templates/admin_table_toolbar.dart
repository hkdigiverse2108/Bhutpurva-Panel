import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminTableToolbar extends StatelessWidget {
  final Widget? search;
  final List<Widget>? filters;
  final List<Widget>? actions;
  final bool hasSpace;

  const AdminTableToolbar({
    super.key,
    this.search,
    this.filters,
    this.actions,
    this.hasSpace = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          if (search != null) Expanded(child: search!),

          if (filters != null && filters!.isNotEmpty) ...[
            if (hasSpace) const Gap(12),
            ...filters!,
          ],

          if (actions != null && actions!.isNotEmpty) ...[
            const Spacer(),
            ...actions!,
          ],
        ],
      ),
    );
  }
}
