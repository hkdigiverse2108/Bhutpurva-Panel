import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/manage_batches/batch_list/controllers/batch_list_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_Icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_shimmer.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchListDesktop extends StatelessWidget {
  const BatchListDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BatchListController.instance;
    final LayerLink statusFilterLink = LayerLink();

    return AdminTablePageLayout(
      header: BreadcrumbWithHeading(
        heading: 'Batch List',
        breadcrumbsItems: [BreadcrumbItem(title: 'Batch List')],
      ),
      toolbar: AdminTableToolbar(
        search: TableSearchField(
          controller: controller.searchController,
          hint: 'Search Batch...',
          onSearchChanged: controller.onSearchChanged,
        ),
        actions: [
          TableActionButton(
            color: ColorConst.primary,
            label: 'Add Batch',
            icon: Icons.add,
            onTap: () {
              controller.onCreateBatch();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppTableShimmer(
            columnWidths: [
              60, // No
              null, // Name (flex)
              null,
              120,
              140,
            ],
          );
        }
        return AppPaginatedTable(
          columns: const [
            AppTableColumn(title: "No", width: 60),
            AppTableColumn(title: "Name"),
            AppTableColumn(title: "Monitors"),
            AppTableColumn(title: "Students", width: 120),
            AppTableColumn(title: "Actions", width: 140),
          ],
          rows: controller.batches,
          onPageChanged: (page) {},
          rowBuilder: (item, index) {
            return DataRow(
              cells: [
                DataCell(Text(item.id)),
                DataCell(
                  Text(item.name, style: TextStyle(color: ColorConst.primary)),
                  onTap: () {
                    Get.toNamed(AppPages.batchDetails);
                  },
                ),
                DataCell(Text(item.monitor)),
                DataCell(Text(item.students.length.toString())),
                DataCell(
                  Row(
                    children: [
                      tableActionIconButton(icon: Icons.edit, onTap: () {}),
                      const SizedBox(width: 6),
                      tableActionIconButton(
                        icon: Icons.delete,
                        color: Colors.red,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
              color: TableHelpers.rowHoverColor(),
            );
          },
          rowsPerPage: 10,
        );
      }),
    );
  }
}
