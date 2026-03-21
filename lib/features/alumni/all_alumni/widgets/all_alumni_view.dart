import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/alumni/all_alumni/controllers/all_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
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

class AllAlumniView extends StatelessWidget {
  const AllAlumniView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AllAlumniController.instance;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        return Obx(
          () => AdminTablePageLayout(
            header: BreadcrumbWithHeading(
              heading: 'All Alumni',
              breadcrumbsItems: [BreadcrumbItem(title: 'All Alumni')],
            ),
            toolbar: isMobile
                ? Column(
                    children: [
                      AdminTableToolbar(
                        filters: [
                          TableFilterButton(
                            onTap: () {
                              controller.showFilter.toggle();
                            },
                            label: 'Filter',
                            icon: Icons.filter_list,
                          ),
                        ],
                        actions: [
                          TableActionButton(
                            color: ColorConst.primary,
                            label: 'Generate List',
                            icon: Icons.print,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const Gap(16),
                      AdminTableToolbar(
                        search: TableSearchField(
                          controller: controller.searchController,
                          hint: 'Search Batch...',
                          onSearchChanged: controller.onSearchChanged,
                        ),
                      ),
                    ],
                  )
                : AdminTableToolbar(
                    search: TableSearchField(
                      controller: controller.searchController,
                      hint: 'Search Batch...',
                      onSearchChanged: controller.onSearchChanged,
                    ),
                    filters: [
                      TableFilterButton(
                        onTap: () {
                          controller.showFilter.toggle();
                        },
                        label: 'Filter',
                        icon: Icons.filter_list,
                      ),
                    ],
                    actions: [
                      TableActionButton(
                        color: ColorConst.primary,
                        label: 'Generate List',
                        icon: Icons.print,
                        onTap: () {},
                      ),
                    ],
                  ),
            filter: AdminTableFilter(
              children: [
                TableFilterField(
                  label: 'Age',
                  hint: 'Select age',
                  value: controller.ageFilter.value,
                  items: controller.batches
                      .map(
                        (age) =>
                            AdminDropdownItem(value: age.id, label: age.name),
                      )
                      .toList(),
                  onChanged: controller.onAgeChanged,
                ),
                TableFilterField(
                  label: 'Role',
                  hint: 'Select role',
                  value: controller.roleFilter.value,
                  items: controller.batches
                      .map(
                        (batch) => AdminDropdownItem(
                          value: batch.id,
                          label: batch.name,
                        ),
                      )
                      .toList(),
                  onChanged: controller.onRoleChanged,
                ),
              ],
            ),
            showFilter: controller.showFilter.value,
            body: Obx(() {
              if (controller.isLoading.value) {
                return const AppTableShimmer(
                  columnWidths: [60, null, null, null, 120, 140],
                );
              }
              return AppPaginatedTable(
                columns: const [
                  AppTableColumn(
                    title: 'No',
                    width: 60,
                    textAlign: TextAlign.center,
                  ),
                  AppTableColumn(title: 'Name'),
                  AppTableColumn(title: 'Mobile Number'),
                  AppTableColumn(title: 'City'),
                  AppTableColumn(
                    title: 'Status',
                    width: 120,
                    textAlign: TextAlign.center,
                  ),
                  AppTableColumn(
                    title: 'Actions',
                    width: 140,
                    textAlign: TextAlign.center,
                  ),
                ],
                rows: controller.allAlumni,
                totalRows: controller.total,
                rowsPerPage: controller.rowsPerPage,
                checkboxColumn: !isMobile,
                onPageChanged: controller.onPageChange,
                rowBuilder: (item, index) {
                  return DataRow(
                    color: TableHelpers.rowHoverColor(),
                    cells: [
                      DataCell(Center(child: Text((index + 1).toString()))),
                      DataCell(Text(item.name)),
                      DataCell(Text(item.phoneNumber)),
                      DataCell(
                        Text(
                          item.addressIds.isNotEmpty
                              ? item.addressIds.first.city
                              : 'N/A',
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            item.isVerified ? 'Verified' : 'Not Verified',
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              tableActionIconButton(
                                onTap: () {
                                  controller.onEditStudent(item.id);
                                },
                                icon: Icons.edit,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }
}
