import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/manage_groups/group_list/controllers/group_list_controller.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_Icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_filter_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_shimmer.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupListDesktop extends StatelessWidget {
  const GroupListDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GroupListController.instance;
    final LayerLink statusFilterLink = LayerLink();

    return Scaffold(
      body: AdminTablePageLayout(
        header: BreadcrumbWithHeading(
          heading: 'Group List',
          breadcrumbsItems: [BreadcrumbItem(title: 'Groups')],
        ),
        toolbar: AdminTableToolbar(
          search: TableSearchField(
            controller: controller.searchController,
            hint: 'Search Group...',
            onSearchChanged: controller.onSearchChanged,
          ),
          filters: [
            CompositedTransformTarget(
              link: statusFilterLink,
              child: TableFilterButton(
                label: controller.statusFilterLabel.value,
                isActive: controller.isStatusFilterActive,
                onTap: () {
                  controller.showStatusFilterMenu(
                    context: context,
                    controller: controller,
                    link: statusFilterLink,
                  );
                },
              ),
            ),
            if (controller.isStatusFilterActive)
              TextButton(
                onPressed: controller.clearFilters,
                child: const Text('Clear filters'),
              ),
          ],

          actions: [
            TableActionButton(
              color: ColorConst.primary,
              label: 'Add Group',
              icon: Icons.add,
              onTap: () {
                controller.onCreateGroup();
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
                null, // Email
                120, // Status
                140, // Actions
              ],
            );
          }

          return AppPaginatedTable<GroupModel>(
            columns: const [
              AppTableColumn(title: "No", width: 60),
              AppTableColumn(title: "Name"),
              AppTableColumn(title: "Leaders"),
              AppTableColumn(title: "Status", width: 120),
              AppTableColumn(title: "Actions", width: 140),
            ],
            rows: controller.groups,
            rowsPerPage: 10,
            onPageChanged: (page) {},
            onAdd: controller.onCreateGroup,
            onRefresh: controller.fetchGroups,
            rowBuilder: (group, index) {
              return DataRow(
                color: TableHelpers.rowHoverColor(),
                cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(
                    Text(
                      group.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: ColorConst.primary),
                    ),
                    onTap: () {
                      controller.onGroupTap(group);
                    },
                  ),
                  DataCell(
                    Text(
                      group.leaders.length.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: group.isActive
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        group.isActive ? "Active" : "Inactive",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: group.isActive
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                        ),
                      ),
                    ),
                  ),
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
              );
            },
          );
        }),
      ),
    );
  }
}
