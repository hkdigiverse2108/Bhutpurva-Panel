import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/programs/program_list/controllers/program_list_controller.dart';
import 'package:bhutpurva_penal/shared/models/program_models/program_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_shimmer.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ProgramListMobile extends StatelessWidget {
  const ProgramListMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProgramListController.instance;

    return AdminTablePageLayout(
      header: const BreadcrumbWithHeading(
        heading: 'Program List',
        breadcrumbsItems: [BreadcrumbItem(title: 'Program List')],
      ),
      toolbar: Column(
        children: [
          AdminTableToolbar(
            actions: [
              TableActionButton(
                color: ColorConst.primary,
                label: 'Add Program',
                icon: Icons.add,
                onTap: () {
                  controller.onCreateProgram();
                },
              ),
            ],
          ),
          const Gap(16),
          AdminTableToolbar(
            search: TableSearchField(
              controller: controller.searchController,
              hint: 'Search Program...',
              onSearchChanged: controller.onSearchChanged,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppTableShimmer(
            columnWidths: [
              60, // No
              null, // Name
              null, // Batch
              120, // Date
              140, // Actions
            ],
          );
        }
        return AppPaginatedTable<Program>(
          columns: const [
            AppTableColumn(title: "No", width: 60),
            AppTableColumn(title: "Name"),
            AppTableColumn(title: "Batch"),
            AppTableColumn(title: "Date", width: 120),
            AppTableColumn(title: "Actions", width: 140),
          ],
          rows: controller.programs,
          totalRows: controller.total,
          rowsPerPage: controller.rowsPerPage,
          onPageChanged: controller.onPageChange,
          rowBuilder: (item, index) {
            return DataRow(
              cells: [
                DataCell(Text((index + 1).toString())),
                DataCell(
                  InkWell(
                    onTap: () => controller.onProgramTap(item),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ColorConst.primary,
                      ),
                    ),
                  ),
                ),
                DataCell(Text(item.batchId.name)),
                DataCell(Text(DateFormat('dd MMM').format(item.date))),
                DataCell(
                  Row(
                    children: [
                      tableActionIconButton(
                        icon: Iconsax.edit,
                        onTap: () {
                          controller.onEditProgram(item);
                        },
                      ),
                      const SizedBox(width: 6),
                      tableActionIconButton(
                        icon: Iconsax.trash,
                        color: Colors.red,
                        onTap: () {
                          controller.onDeleteProgram(item.id);
                        },
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
