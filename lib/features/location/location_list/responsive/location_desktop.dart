import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/location/location_list/controllers/location_controller.dart';
import 'package:bhutpurva_penal/shared/models/location_models/location_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_Icon_button.dart';
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
import 'package:iconsax/iconsax.dart';

class LocationDesktop extends GetView<LocationController> {
  const LocationDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AdminTablePageLayout(
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
          filters: [
            TableFilterButton(
              onTap: () {
                controller.showFilter.toggle();
              },
              label: 'Filter',
              icon: Icons.filter_list,
              isActive: controller.showFilter.value,
            ),
          ],
          actions: [
            TableActionButton(
              color: ColorConst.primary,
              label: 'Add Location',
              icon: Icons.add,
              onTap: () {
                controller.onCreateLocation();
              },
            ),
          ],
        ),
        filter: AdminTableFilter(
          children: [
            TableFilterField<String>(
              label: 'Location Type',
              hint: 'Select Location Type',
              value: controller.typeFilter.value,
              items: controller.locationTypes
                  .map(
                    (type) =>
                        AdminDropdownItem(value: type.name, label: type.name),
                  )
                  .toList(),
              onChanged: (value) {
                controller.typeFilter.value = value ?? '';
                controller.fetchLocations();
              },
            ),
            TableFilterField<String>(
              label: 'Status',
              hint: 'Select Status',
              value: controller.statusFilter.value,
              items: controller.statusTypes
                  .map(
                    (status) => AdminDropdownItem(value: status, label: status),
                  )
                  .toList(),
              onChanged: (value) {
                controller.statusFilter.value = value ?? '';
                controller.fetchLocations();
              },
            ),
          ],
        ),
        showFilter: controller.showFilter.value,
        body: controller.isLoading.value
            ? const AppTableShimmer(
                columnWidths: [60, null, null, null, 120, 140],
              )
            : AppPaginatedTable<LocationModel>(
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
                              icon: Iconsax.edit,
                              onTap: () {
                                Get.toNamed(
                                  AppPages.editLocation,
                                  arguments: {'id': item.id},
                                );
                              },
                              color: Colors.blue,
                            ),
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
              ),
      ),
    );
  }
}
