import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/alumni/all_alumni/controllers/all_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
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
import 'package:get/get.dart';

class AllAlumniDesktop extends StatelessWidget {
  const AllAlumniDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AllAlumniController.instance;
    return Obx(
      () => AdminTablePageLayout(
        header: BreadcrumbWithHeading(
          heading: 'All Alumni',
          breadcrumbsItems: [BreadcrumbItem(title: 'All Alumni')],
        ),
        toolbar: AdminTableToolbar(
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
              // isActive: false,
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
              items: controller.ages
                  .map((age) => AdminDropdownItem(value: age, label: age))
                  .toList(),
              onChanged: controller.onAgeChanged,
            ),
            TableFilterField(
              label: 'Role',
              hint: 'Select role',
              value: controller.roleFilter.value,
              items: controller.roles
                  .map((role) => AdminDropdownItem(value: role, label: role))
                  .toList(),
              onChanged: controller.onRoleChanged,
            ),
          ],
        ),
        showFilter: controller.showFilter.value,
        body: Obx(() {
          if (controller.isLoading.value) {
            return const AppTableShimmer(
              columnWidths: [60, null, null, 60, null, 120, 140],
            );
          }
          return AppPaginatedTable(
            columns: const [
              AppTableColumn(title: 'No', width: 60),
              AppTableColumn(title: 'Name'),
              AppTableColumn(title: 'Mobile Number'),
              AppTableColumn(title: 'age', width: 60),
              AppTableColumn(title: 'Address'),
              AppTableColumn(title: 'Profile Status', width: 120),
              AppTableColumn(title: 'Actions', width: 140),
            ],
            rows: controller.allAlumni,
            rowsPerPage: 10,
            checkboxColumn: true,
            onPageChanged: (page) {},
            rowBuilder: (item, index) {
              return DataRow(
                color: TableHelpers.rowHoverColor(),
                cells: [
                  DataCell(Text(item.id)),
                  DataCell(Text(item.name)),
                  DataCell(Text(item.phone)),
                  DataCell(Text(item.age.toString())),
                  DataCell(Text(item.address)),
                  DataCell(Text(item.profileStatus)),
                  DataCell(
                    Row(
                      children: [
                        TableActionButton(
                          onTap: () {
                            controller.onEditStudent(item);
                          },
                          label: 'Edit Profile',
                          icon: Icons.edit,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
