import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'app_table_columns.dart';
import 'app_table_empty.dart';

class AppDataTable<T> extends StatelessWidget {
  final List<AppTableColumn> columns;
  final List<T> rows;
  final DataRow Function(T item, int index) rowBuilder;

  final bool isLoading;
  final bool showCheckbox;
  final double minWidth;
  final VoidCallback? onAdd;
  final String emptyMessage;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.rowBuilder,
    this.isLoading = false,
    this.showCheckbox = false,
    this.minWidth = 800,
    this.onAdd,
    this.emptyMessage = "No data available",
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading && rows.isEmpty) {
      return AppTableEmpty(message: emptyMessage, onAdd: onAdd);
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _decoration(),
      child: DataTable2(
        minWidth: minWidth,
        headingRowHeight: 48,
        dataRowHeight: 52,
        columnSpacing: 16,
        horizontalMargin: 12,
        showCheckboxColumn: showCheckbox,
        headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
        columns: _buildColumns(),
        rows: List.generate(
          rows.length,
          (index) => rowBuilder(rows[index], index),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return columns
        .map(
          (c) => DataColumn2(
            fixedWidth: c.width,
            label: Text(
              c.title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        )
        .toList();
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12),
      ],
    );
  }
}
