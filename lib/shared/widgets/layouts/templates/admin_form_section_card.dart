import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminFormSectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> fields;
  final Widget? trailing;

  const AdminFormSectionCard({
    super.key,
    required this.title,
    required this.fields,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const Gap(4),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),

          const Gap(16),

          /// FIELDS
          ..._buildFields(),
        ],
      ),
    );
  }

  List<Widget> _buildFields() {
    final List<Widget> widgets = [];

    for (int i = 0; i < fields.length; i++) {
      widgets.add(fields[i]);

      if (i != fields.length - 1) {
        widgets.add(const Gap(12));
      }
    }

    return widgets;
  }
}
