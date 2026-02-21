import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppTableShimmer extends StatelessWidget {
  final List<double?> columnWidths;
  final int rowCount;
  final double rowHeight;
  final double headerHeight;

  const AppTableShimmer({
    super.key,
    required this.columnWidths,
    this.rowCount = 10,
    this.rowHeight = 56,
    this.headerHeight = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _box(),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            /// HEADER
            _header(),

            const Divider(height: 1),

            /// ROWS
            ...List.generate(rowCount, (_) => _row()),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return SizedBox(
      height: headerHeight,
      child: Row(
        children: columnWidths
            .map((w) => _cell(width: w, height: 16, isHeader: true))
            .toList(),
      ),
    );
  }

  Widget _row() {
    return SizedBox(
      height: rowHeight,
      child: Row(
        children: columnWidths.map((w) => _cell(width: w, height: 14)).toList(),
      ),
    );
  }

  Widget _cell({double? width, required double height, bool isHeader = false}) {
    return Expanded(
      flex: width == null ? 1 : 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _box() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }
}
