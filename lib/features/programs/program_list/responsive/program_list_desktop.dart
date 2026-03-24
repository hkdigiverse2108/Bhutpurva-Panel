import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/programs/program_list/controllers/program_list_controller.dart';
import 'package:bhutpurva_penal/shared/models/program_models/program_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/icons/icons.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProgramListDesktop extends StatelessWidget {
  const ProgramListDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProgramListController.instance;

    return AdminTablePageLayout(
      header: const BreadcrumbWithHeading(
        heading: 'Programs',
        breadcrumbsItems: [BreadcrumbItem(title: 'Programs')],
      ),
      toolbar: AdminTableToolbar(
        search: TableSearchField(
          controller: controller.searchController,
          hint: 'Search programs...',
          onSearchChanged: controller.onSearchChanged,
        ),
        actions: [
          TableActionButton(
            label: 'Add Program',
            onTap: controller.onCreateProgram,
            icon: Icons.add,
            color: ColorConst.primary,
          ),
        ],
      ),
      body: Obx(
        () => AppPaginatedTable<Program>(
          columns: const [
            AppTableColumn(title: 'Name'),
            AppTableColumn(title: 'Batch'),
            AppTableColumn(title: 'Description'),
            AppTableColumn(title: 'Date'),
            AppTableColumn(title: 'Actions', width: 100),
          ],
          rows: controller.programs,
          totalRows: controller.total,
          rowsPerPage: controller.rowsPerPage,
          isLoading: controller.isLoading.value,
          onPageChanged: controller.onPageChange,
          onRefresh: controller.fetchPrograms,
          onAdd: controller.onCreateProgram,
          rowBuilder: (program, index) {
            return DataRow(
              cells: [
                DataCell(
                  InkWell(
                    onTap: () => controller.onProgramTap(program),
                    child: Text(
                      program.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ColorConst.primary,
                      ),
                    ),
                  ),
                ),
                DataCell(Text(program.batchId.name)),
                DataCell(
                  Tooltip(
                    message: program.description,
                    child: Text(
                      program.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(Text(DateFormat('dd MMM yyyy').format(program.date))),
                DataCell(
                  Row(
                    children: [
                      tableActionIconButton(
                        icon: AppIcons.edit,
                        onTap: () {
                          controller.onEditProgram(program);
                        },
                      ),
                      const SizedBox(width: 6),
                      tableActionIconButton(
                        icon: AppIcons.delete,
                        color: Colors.red,
                        onTap: () {
                          controller.onDeleteProgram(program.id);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
