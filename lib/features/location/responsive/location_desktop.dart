import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/location/controllers/location_controller.dart';
import 'package:bhutpurva_penal/shared/models/location_models/location_model.dart';
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

class LocationDesktop extends GetView<LocationController> {
  const LocationDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminTablePageLayout(
      header: BreadcrumbWithHeading(
        heading: 'Location',
        breadcrumbsItems: [BreadcrumbItem(title: 'Location')],
      ),
      toolbar: AdminTableToolbar(
        search: TableSearchField(
          controller: controller.searchController,
          hint: 'Search Location...',
          onSearchChanged: controller.onSearchChanged,
        ),
        actions: [SizedBox()],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppTableShimmer(
            columnWidths: [60, null, null, null, 120, 140],
          );
        }
        return AppPaginatedTable<LocationModel>(
          columns: [
            AppTableColumn(title: 'No', width: 60),
            AppTableColumn(title: 'Location'),
            AppTableColumn(title: 'Type'),
            AppTableColumn(title: 'Status'),
            AppTableColumn(title: 'Action', width: 140),
          ],
          rows: controller.locations,
          totalRows: controller.total,
          rowsPerPage: controller.rowsPerPage,
          onPageChanged: controller.onPageChange,
          rowBuilder: (item, index) {
            return DataRow(
              color: TableHelpers.rowHoverColor(),
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(item.name)),
                DataCell(Text(item.type)),
                DataCell(Text(item.isActive ? 'Active' : 'Inactive')),

                DataCell(
                  Row(
                    children: [
                      tableActionIconButton(
                        icon: Iconsax.trash,
                        onTap: () {
                          controller.deleteLocation(item.id);
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
