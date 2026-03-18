import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'app_table_columns.dart';
import 'app_table_empty.dart';

class AppPaginatedTable<T> extends StatelessWidget {
  final List<AppTableColumn> columns;
  final List<T> rows;
  final DataRow Function(T item, int index) rowBuilder;

  final int? totalRows;
  final int rowsPerPage;
  final bool isLoading;

  final void Function(int page)? onPageChanged;
  final VoidCallback? onAdd;
  final VoidCallback? onRefresh;
  final bool checkboxColumn;

  const AppPaginatedTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.rowBuilder,
    this.totalRows,
    required this.rowsPerPage,
    this.onPageChanged,
    this.onAdd,
    this.onRefresh,
    this.isLoading = false,
    this.checkboxColumn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
      ),
      child: PaginatedDataTable2(
        empty: !isLoading
            ? AppTableEmpty(
                message: "No records found",
                onAdd: onAdd,
                onRefresh: onRefresh,
              )
            : null,
        minWidth: 900,
        columnSpacing: 20,
        horizontalMargin: 16,
        dataRowHeight: 56,
        headingRowHeight: 50,
        dividerThickness: 0.1,
        renderEmptyRowsInTheEnd: false,
        rowsPerPage: rowsPerPage,
        autoRowsToHeight: true,
        showCheckboxColumn: checkboxColumn,
        headingRowColor: WidgetStateProperty.all(Colors.grey.shade50),
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Colors.black87,
        ),
        columns: columns
            .map(
              (c) => DataColumn2(
                fixedWidth: c.width,
                label: Text(
                  c.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            )
            .toList(),
        source: _TableSource<T>(
          data: rows,
          rowBuilder: rowBuilder,
          totalCount: totalRows ?? rows.length,
          rowsPerPage: rowsPerPage,
        ),
        onPageChanged: onPageChanged,
      ),
    );
  }
}

class _TableSource<T> extends DataTableSource {
  final List<T> data;
  final DataRow Function(T item, int index) rowBuilder;
  final int totalCount;
  final int rowsPerPage;

  _TableSource({
    required this.data,
    required this.rowBuilder,
    required this.totalCount,
    required this.rowsPerPage,
  });

  @override
  DataRow? getRow(int index) {
    if (data.isEmpty) return null;
    // For server-side pagination, the 'data' list usually only contains the current page.
    // DataTableSource expects index to be global (0 to totalCount - 1).
    // We map it to local index (0 to data.length - 1).
    final localIndex = index % rowsPerPage;
    if (localIndex >= data.length) return null;
    return rowBuilder(data[localIndex], index);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalCount;

  @override
  int get selectedRowCount => 0;
}
