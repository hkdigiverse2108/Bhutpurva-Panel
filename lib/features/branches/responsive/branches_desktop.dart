import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/branches/controllers/branches_controller.dart';
import 'package:bhutpurva_penal/shared/models/branch_models/branch_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_Icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_shimmer.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BranchesDesktop extends GetView<BranchesController> {
  const BranchesDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminTablePageLayout(
      header: BreadcrumbWithHeading(
        heading: 'Branches',
        breadcrumbsItems: [BreadcrumbItem(title: 'Branches')],
      ),
      toolbar: AdminTableToolbar(
        search: TableSearchField(
          controller: controller.searchController,
          hint: 'Search Branch...',
          onSearchChanged: controller.onSearchChanged,
        ),
        actions: [const SizedBox()],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppTableShimmer(columnWidths: [60, null, 140]);
        }
        return AppPaginatedTable<BranchModel>(
          columns: [
            AppTableColumn(title: 'No', width: 60),
            AppTableColumn(title: 'Branch Name'),
            AppTableColumn(title: 'Status'),
            AppTableColumn(title: 'Action', width: 140),
          ],
          rows: controller.branches,
          totalRows: controller.total,
          rowsPerPage: controller.limit,
          onPageChanged: controller.onPageChanged,
          rowBuilder: (item, index) {
            return DataRow(
              color: TableHelpers.rowHoverColor(),
              cells: [
                DataCell(
                  Text(
                    '${(controller.page - 1) * controller.limit + index + 1}',
                  ),
                ),
                DataCell(Text(item.name)),
                DataCell(Text(item.isActive ? 'Active' : 'Inactive')),

                DataCell(
                  Row(
                    children: [
                      tableActionIconButton(
                        icon: Iconsax.trash,
                        onTap: () {
                          controller.deleteBranch(item.id);
                        },
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
