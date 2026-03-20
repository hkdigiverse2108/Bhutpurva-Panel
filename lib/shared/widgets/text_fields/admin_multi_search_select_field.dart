import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AdminMultiSearchSelectField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final List<AdminDropdownItem<T>> items;
  final List<T> selectedItems;
  final ValueChanged<T> onAdded;
  final ValueChanged<T> onRemoved;
  final String Function(T) itemLabelBuilder;

  const AdminMultiSearchSelectField({
    super.key,
    required this.label,
    required this.items,
    required this.selectedItems,
    required this.onAdded,
    required this.onRemoved,
    required this.itemLabelBuilder,
    this.hint = "Select",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdminSearchSelectField<T>(
          label: label,
          hint: hint,
          items: items,
          onChanged: (item) {
            if (item != null) {
              onAdded(item);
            }
          },
        ),
        if (selectedItems.isNotEmpty) ...[
          const Gap(12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedItems.map((item) {
              return Chip(
                label: Text(
                  itemLabelBuilder(item),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: ColorConst.black),
                ),
                onDeleted: () => onRemoved(item),
                deleteIcon: const Icon(PhosphorIconsBold.x, size: 14),
                deleteIconColor: ColorConst.error,
                backgroundColor: ColorConst.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
