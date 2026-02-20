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
    this.isLoading = false,
    this.checkboxColumn = false,
  });

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty && !isLoading) {
      return AppTableEmpty(message: "No records found", onAdd: onAdd);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: PaginatedDataTable2(
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
        source: _TableSource<T>(data: rows, rowBuilder: rowBuilder),
        onPageChanged: onPageChanged,
      ),
    );
  }
}

class _TableSource<T> extends DataTableSource {
  final List<T> data;
  final DataRow Function(T item, int index) rowBuilder;

  _TableSource({required this.data, required this.rowBuilder});

  @override
  DataRow getRow(int index) {
    return rowBuilder(data[index], index);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
