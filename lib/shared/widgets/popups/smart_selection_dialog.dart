import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartSelectionDialog<T> extends StatelessWidget {
  const SmartSelectionDialog({
    super.key,
    required this.title,
    required this.selectedItems,
    required this.itemBuilder,
    this.existingItems,
    this.onRemoveExisting,
    this.searchWidget,
    this.onRemove,
    this.onTabChanged,
    this.maxHeight = 600,
    this.maxListHeight = 450,
    this.width = 520,
    this.onCancel,
    this.onDone,
  });

  /// 🔹 Title
  final String title;

  /// 🔹 Selected items list (to be added)
  final RxList<T> selectedItems;

  /// 🔹 Existing items list (already assigned)
  final RxList<T>? existingItems;

  /// 🔹 Item UI
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// 🔹 Optional search bar (you inject your own)
  final Widget? searchWidget;

  /// 🔹 Remove callback for selected items
  final void Function(T item)? onRemove;

  /// 🔹 Remove callback for existing items
  final void Function(T item)? onRemoveExisting;

  /// 🔹 Tab change callback
  final ValueChanged<int>? onTabChanged;

  final VoidCallback? onCancel;
  final VoidCallback? onDone;

  final double maxHeight;
  final double maxListHeight;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width, maxHeight: maxHeight),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 TITLE
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              /// 🔹 SEARCH (CUSTOM)
              if (searchWidget != null) ...[
                searchWidget!,
                const SizedBox(height: 16),
              ],

              /// 🔹 ITEMS AREA
              Expanded(
                child: Container(
                  constraints: BoxConstraints(maxHeight: maxListHeight),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Obx(() {
                    final hasExisting =
                        existingItems != null && existingItems!.isNotEmpty;
                    final hasSelected = selectedItems.isNotEmpty;

                    if (!hasExisting && !hasSelected) {
                      return const Center(
                        child: Text(
                          'No items selected',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return Scrollbar(
                      child: ListView(
                        children: [
                          if (hasExisting) ...[
                            _sectionHeader('Assigned Members'),
                            const SizedBox(height: 8),
                            ...existingItems!.map(
                              (item) =>
                                  _itemWrapper(context, item, onRemoveExisting),
                            ),
                            if (hasSelected) const SizedBox(height: 20),
                          ],
                          if (hasSelected) ...[
                            _sectionHeader(
                              hasExisting ? 'To Add' : 'Selected Members',
                            ),
                            const SizedBox(height: 8),
                            ...selectedItems.map(
                              (item) => _itemWrapper(context, item, onRemove),
                            ),
                          ],
                        ],
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 12),

              /// 🔹 ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onCancel ?? () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: onDone ?? () => Navigator.pop(context),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade600,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _itemWrapper(context, T item, void Function(T item)? onRemove) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          itemBuilder(context, item),
          if (onRemove != null)
            InkWell(
              onTap: () => onRemove(item),
              child: Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: const Icon(Icons.close, size: 14, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
