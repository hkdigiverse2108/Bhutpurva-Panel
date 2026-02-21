import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

void main() {
  var table = PaginatedDataTable2(
    columns: const [],
    source: _DummySource(),
    empty: const Text('Empty'),
  );
}

class _DummySource extends DataTableSource {
  @override
  DataRow? getRow(int index) => null;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => 0;
  @override
  int get selectedRowCount => 0;
}
