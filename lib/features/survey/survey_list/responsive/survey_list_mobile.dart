import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/survey/survey_list/controllers/survey_list_controller.dart';
import 'package:bhutpurva_penal/shared/models/survey_models/survey_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_filter_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_filter.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_shimmer.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_filter_field.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SurveyListMobile extends GetView<SurveyListController> {
  const SurveyListMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AdminTablePageLayout(
        header: const BreadcrumbWithHeading(
          heading: 'Surveys',
          breadcrumbsItems: [BreadcrumbItem(title: 'Surveys')],
        ),
        toolbar: Column(
          children: [
            AdminTableToolbar(
              search: TableSearchField(
                controller: controller.searchController,
                hint: 'Search Survey...',
                onSearchChanged: controller.onSearchChanged,
              ),
              filters: [
                TableFilterButton(
                  onTap: () => controller.showFilter.toggle(),
                  label: "Filter",
                  icon: Iconsax.filter,
                  isActive: controller.showFilter.value,
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: TableActionButton(
                    label: 'Create Survey',
                    onTap: () => Get.toNamed(AppPages.createSurvey),
                    icon: Iconsax.add,
                  ),
                ),
              ],
            ),
          ],
        ),
        filter: AdminTableFilter(
          onReset: controller.resetFilters,
          children: [
            TableFilterField<String?>(
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
            TableFilterField<String?>(
              label: 'Group',
              hint: 'Group',
              value: controller.groupIdFilter.value,
              items: controller.groupDropdownItems,
              onChanged: controller.onGroupFilterChanged,
            ),
            TableFilterField<String?>(
              label: 'Batch',
              hint: 'Batch',
              value: controller.batchIdFilter.value,
              items: controller.batchDropdownItems,
              onChanged: controller.onBatchFilterChanged,
            ),
          ],
        ),
        showFilter: controller.showFilter.value,
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return const AppTableShimmer(columnWidths: [null, 80, 100]);
            }

            return AppPaginatedTable<SurveyModel>(
              columns: const [
                AppTableColumn(title: 'Title'),
                AppTableColumn(title: 'Status', width: 80),
                AppTableColumn(title: 'Action', width: 120),
              ],
              rows: controller.surveys,
              totalRows: controller.total.value,
              rowsPerPage: controller.rowsPerPage.value,
              onPageChanged: controller.onPageChange,
              rowBuilder: (item, index) {
                return DataRow(
                  color: TableHelpers.rowHoverColor(),
                  cells: [
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            item.scope.capitalizeFirst ?? '',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
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
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                          const Gap(4),
                          tableActionIconButton(
                            icon: Iconsax.message_text,
                            onTap: () => Get.toNamed(
                              AppPages.surveyResponses(item.id),
                              arguments: item.id,
                            ),
                            color: Colors.green,
                          ),
                          const Gap(4),
                          tableActionIconButton(
                            icon: Iconsax.trash,
                            onTap: () => controller.deleteSurvey(item.id),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
