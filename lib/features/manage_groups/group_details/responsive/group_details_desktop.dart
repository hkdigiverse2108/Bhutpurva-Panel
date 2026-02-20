import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/manage_groups/group_details/controllers/group_details_controller.dart';
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
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GroupDetailsDesktop extends StatelessWidget {
  const GroupDetailsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GroupDetailsController.instance;
    return Scaffold(
      body: AdminTablePageLayout(
        header: BreadcrumbWithHeading(
          heading: 'Group Details',
          breadcrumbsItems: [
            BreadcrumbItem(title: 'Groups', route: AppPages.manageGroups),
            BreadcrumbItem(title: 'Group Details'),
          ],
          returnToPreviousScreen: true,
        ),
        toolbar: AdminTableToolbar(
          search: TableSearchField(
            controller: controller.searchController,
            hint: 'Search Batch...',
            onSearchChanged: controller.onSearchChanged,
          ),
          filters: [
            TableActionButton(
              onTap: () {},
              label: 'Add Devotee',
              icon: Icons.add,
              color: ColorConst.primary,
            ),
          ],
          actions: [
            Obx(
              () => (controller.tab.value == 0)
                  ? TableActionButton(
                      onTap: () {
                        controller.tab.value = 1;
                      },
                      label: 'Switch To Leaders',
                      icon: PhosphorIconsBold.userSwitch,
                      color: ColorConst.primary,
                    )
                  : TableActionButton(
                      onTap: () {
                        controller.tab.value = 0;
                      },
                      label: 'Switch To Batches',
                      icon: PhosphorIconsBold.swatches,
                      color: ColorConst.primary,
                    ),
            ),
          ],
        ),
        body: Obx(() {
          Widget child;

          if (controller.tab.value == 0) {
            if (controller.isBatchesLoading.value) {
              child = const AppTableShimmer(
                key: ValueKey('batches_shimmer'),
                columnWidths: [60, null, null, 120, 140],
              );
            } else {
              child = AppPaginatedTable(
                key: const ValueKey('batches_table'),
                columns: const [
                  AppTableColumn(title: "No", width: 60),
                  AppTableColumn(title: "Name"),
                  AppTableColumn(title: "Monitors"),
                  AppTableColumn(title: "Students", width: 120),
                  AppTableColumn(title: "Actions", width: 140),
                ],
                rows: controller.batches,
                rowsPerPage: 10,
                onPageChanged: (page) {},
                rowBuilder: (item, index) {
                  return DataRow(
                    color: TableHelpers.rowHoverColor(),
                    cells: [
                      DataCell(Text(item.id)),
                      DataCell(
                        Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: ColorConst.primary),
                        ),
                        onTap: () {
                          controller.onBatchTap(item);
                        },
                      ),
                      DataCell(Text(item.monitor)),
                      DataCell(Text(item.students.length.toString())),
                      DataCell(
                        Row(
                          children: [
                            tableActionIconButton(
                              icon: Icons.edit,
                              onTap: () {},
                            ),
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
            }
          } else {
            if (controller.isLeadersLoading.value) {
              child = const AppTableShimmer(
                key: ValueKey('leaders_shimmer'),
                columnWidths: [60, null, null, 60, null, 120, 140],
              );
            } else {
              child = AppPaginatedTable(
                key: const ValueKey('leaders_table'),
                columns: const [
                  AppTableColumn(title: 'No', width: 60),
                  AppTableColumn(title: 'Name'),
                  AppTableColumn(title: 'Mobile Number'),
                  AppTableColumn(title: 'Age', width: 60),
                  AppTableColumn(title: 'Address'),
                  AppTableColumn(title: 'Profile Status', width: 120),
                  AppTableColumn(title: 'Actions', width: 140),
                ],
                rows: controller.leaders,
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
                        TableActionButton(
                          onTap: () {
                            controller.onEditStudent(item);
                          },
                          label: 'Edit Profile',
                          icon: Icons.edit,
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.04),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: child,
          );
        }),
      ),
    );
  }
}
