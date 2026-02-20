import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminSearchSelectField<T> extends StatefulWidget {
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final T? value;
  final List<AdminDropdownItem<T>> items;
  final ValueChanged<T?> onChanged;
  final int maxVisibleItems;
  final bool outSide;

  const AdminSearchSelectField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint = "Select",
    this.prefixIcon,
    this.maxVisibleItems = 6,
    this.outSide = false,
  });

  @override
  State<AdminSearchSelectField<T>> createState() =>
      _AdminSearchSelectFieldState<T>();
}

class _AdminSearchSelectFieldState<T> extends State<AdminSearchSelectField<T>> {
  final LayerLink _link = LayerLink();
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _entry;

  late List<AdminDropdownItem<T>> _filtered;

  static const double _itemHeight = 48.0;
  static const double _gap = 8.0;
  static const double _minHeight = 80.0;

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;

    final selected = widget.items
        .where((e) => e.value == widget.value)
        .cast<AdminDropdownItem<T>?>()
        .firstOrNull;

    if (selected != null) {
      _controller.text = selected.label;
    }
  }

  void _removeOverlay() {
    _entry?.remove();
    _entry = null;
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final offset = box.localToGlobal(Offset.zero);

    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final keyboardHeight = media.viewInsets.bottom;

    final spaceBelow = screenHeight - offset.dy - size.height - keyboardHeight;
    final spaceAbove = offset.dy;

    final maxHeight = widget.maxVisibleItems * _itemHeight;

    final bool openUpwards = spaceBelow < maxHeight && spaceAbove > spaceBelow;

    final availableHeight = openUpwards ? spaceAbove : spaceBelow;

    final desiredHeight = (_filtered.length * _itemHeight).clamp(0, maxHeight);

    final dropdownHeight = desiredHeight.clamp(
      _minHeight,
      availableHeight - _gap,
    );

    _entry = OverlayEntry(
      builder: (_) {
        return Positioned.fill(
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removeOverlay,
              ),
              CompositedTransformFollower(
                link: _link,
                showWhenUnlinked: false,
                offset: openUpwards
                    ? Offset(0, -dropdownHeight - _gap)
                    : Offset(0, size.height + _gap),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: size.width,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: dropdownHeight.toDouble(),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _filtered.length,
                        itemBuilder: (_, index) {
                          final item = _filtered[index];
                          return InkWell(
                            onTap: () {
                              _controller.text = item.label;
                              widget.onChanged(item.value);
                              _removeOverlay();
                            },
                            child: Container(
                              height: _itemHeight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(item.label),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(_entry!);
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.outSide) ...[
          Text(widget.label, style: Theme.of(context).textTheme.bodySmall),
          const Gap(6),
        ],
        CompositedTransformTarget(
          link: _link,
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              label: widget.outSide
                  ? null
                  : Text(
                      widget.label,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
              hintText: widget.hint,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(widget.prefixIcon)
                  : null,
              suffixIcon: const Icon(Icons.keyboard_arrow_down),
            ),
            onTap: () {
              if (_entry == null) {
                _filtered = widget.items;
                _showOverlay();
              }
            },
            onChanged: (value) {
              _filtered = widget.items
                  .where(
                    (e) => e.label.toLowerCase().contains(value.toLowerCase()),
                  )
                  .toList();

              if (_entry == null) {
                _showOverlay();
              } else {
                _entry!.markNeedsBuild();
              }
            },
          ),
        ),
      ],
    );
  }
}

class AdminDropdownItem<T> {
  final T value;
  final String label;

  AdminDropdownItem({required this.value, required this.label});
}
