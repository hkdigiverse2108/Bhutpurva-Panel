import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartSelectionDialog<T> extends StatelessWidget {
  const SmartSelectionDialog({
    super.key,
    required this.title,
    required this.selectedItems,
    required this.itemBuilder,
    this.searchWidget,
    this.onRemove,
    this.onTabChanged,
    this.maxHeight = 560,
    this.maxListHeight = 450,
    this.width = 520,
    this.onCancel,
    this.onDone,
  });

  /// 🔹 Title
  final String title;

  /// 🔹 Selected items list
  final RxList<T> selectedItems;

  /// 🔹 Item UI
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// 🔹 Optional search bar (you inject your own)
  final Widget? searchWidget;

  /// 🔹 Remove callback
  final void Function(T item)? onRemove;

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

              /// 🔹 SELECTED ITEMS AREA
              Expanded(
                child: Container(
                  constraints: BoxConstraints(maxHeight: maxListHeight),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Obx(
                    () => selectedItems.isEmpty
                        ? const Center(
                            child: Text(
                              'No items selected',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : Scrollbar(
                            child: ListView.separated(
                              itemCount: selectedItems.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final item = selectedItems[index];
                                return Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    itemBuilder(context, item),
                                    if (onRemove != null)
                                      InkWell(
                                        onTap: () => onRemove!(item),
                                        child: const Padding(
                                          padding: EdgeInsets.all(6),
                                          child: Icon(Icons.close, size: 18),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// 🔹 ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => onCancel ?? Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () => onDone ?? Navigator.pop(context),
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
}
