import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/life_light/controllers/life_light_controller.dart';
import 'package:bhutpurva_penal/shared/models/life_light_models/life_light_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_shimmer.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart'
    show TableSearchField;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class LifeLightDesktop extends GetView<LifeLightController> {
  const LifeLightDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminTablePageLayout(
      header: BreadcrumbWithHeading(
        heading: 'Life Light',
        breadcrumbsItems: [BreadcrumbItem(title: 'Life Light')],
      ),
      toolbar: AdminTableToolbar(
        search: TableSearchField(
          controller: controller.searchController,
          hint: 'Search Group...',
          onSearchChanged: controller.onSearchChanged,
        ),
        actions: [
          TableActionButton(
            onTap: () => controller.openUploadImagePopup(),
            icon: Iconsax.image,
            label: "Life Light Image",
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppTableShimmer(
            columnWidths: [60, null, null, null, 120, 140],
          );
        }
        return AppPaginatedTable<LifeLightModel>(
          columns: [
            AppTableColumn(title: 'No', width: 60),
            AppTableColumn(title: 'Name'),
            AppTableColumn(title: 'Email'),
            AppTableColumn(title: 'Message'),
            AppTableColumn(title: 'Created At', width: 120),
            AppTableColumn(title: 'Action', width: 140),
          ],
          rows: controller.lifeLight,
          totalRows: controller.total,
          rowsPerPage: controller.rowsPerPage,
          onPageChanged: controller.onPageChange,
          rowBuilder: (item, index) {
            return DataRow(
              color: TableHelpers.rowHoverColor(),
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(item.userId.name)),
                DataCell(Text(item.userId.email)),
                DataCell(Text(item.lifeLight)),
                DataCell(
                  Text(
                    DateFormat(
                      'dd, MMM yyyy',
                    ).format(DateTime.parse(item.createdAt.toString())),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      tableActionIconButton(
                        icon: Iconsax.trash,
                        onTap: () {
                          controller.deleteLifeLight(item.id);
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
