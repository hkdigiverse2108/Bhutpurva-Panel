import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/survey/survey_list/controllers/survey_list_controller.dart';
import 'package:bhutpurva_penal/shared/models/survey_models/survey_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_shimmer.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class SurveyListDesktop extends GetView<SurveyListController> {
  const SurveyListDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminTablePageLayout(
      header: BreadcrumbWithHeading(
        heading: 'Surveys',
        breadcrumbsItems: [BreadcrumbItem(title: 'Surveys')],
      ),
      toolbar: AdminTableToolbar(
        search: TableSearchField(
          controller: controller.searchController,
          hint: 'Search Survey...',
          onSearchChanged: controller.onSearchChanged,
        ),
        filters: [
          Obx(
            () => SizedBox(
              width: 150,
              child: AdminSearchSelectField<String?>(
                label: 'Scope',
                hint: 'Scope',
                value: controller.scopeFilter.value,
                items: [
                  AdminDropdownItem(value: null, label: 'All'),
                  AdminDropdownItem(value: 'overall', label: 'Overall'),
                  AdminDropdownItem(value: 'group', label: 'Group'),
                  AdminDropdownItem(value: 'batch', label: 'Batch'),
                ],
                onChanged: controller.onScopeFilterChanged,
              ),
            ),
          ),
        ],
        actions: [
          TableActionButton(
            label: 'Create Survey',
            onTap: () => Get.toNamed(AppPages.createSurvey),
            icon: Iconsax.add,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppTableShimmer(
            columnWidths: [60, null, 100, 100, 120, 140],
          );
        }
        return AppPaginatedTable<SurveyModel>(
          columns: [
            AppTableColumn(title: 'No', width: 60),
            AppTableColumn(title: 'Title'),
            AppTableColumn(title: 'Scope', width: 100),
            AppTableColumn(title: 'Status', width: 100),
            AppTableColumn(title: 'Created At', width: 120),
            AppTableColumn(title: 'Action', width: 140),
          ],
          rows: controller.surveys,
          totalRows: controller.total,
          rowsPerPage: controller.rowsPerPage,
          onPageChanged: controller.onPageChange,
          rowBuilder: (item, index) {
            return DataRow(
              color: TableHelpers.rowHoverColor(),
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(item.title)),
                DataCell(Text(item.scope.capitalizeFirst ?? '')),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: item.isActive
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.isActive ? "Active" : "Inactive",
                      style: TextStyle(
                        color: item.isActive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    item.createdAt != null
                        ? DateFormat('dd MMM yyyy').format(item.createdAt!)
                        : '-',
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      tableActionIconButton(
                        icon: Iconsax.edit,
                        onTap: () => Get.toNamed(
                          AppPages.editSurvey,
                          arguments: item.id,
                        ),
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      tableActionIconButton(
                        icon: Iconsax.message_text,
                        onTap: () => Get.toNamed(
                          '/survey-responses/${item.id}',
                          arguments: item.id,
                        ),
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      tableActionIconButton(
                        icon: Iconsax.trash,
                        onTap: () {
                          controller.deleteSurvey(item.id);
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
