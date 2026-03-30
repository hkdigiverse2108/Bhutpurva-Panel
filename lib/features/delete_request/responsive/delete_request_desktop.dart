import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/delete_request/controllers/delete_request_controller.dart';
import 'package:bhutpurva_penal/shared/models/delet_request_models/delete_requset_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/icons/icons.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';

class DeleteRequestDesktop extends StatelessWidget {
  const DeleteRequestDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DeleteRequestController.instance;

    return AdminTablePageLayout(
      header: const BreadcrumbWithHeading(
        heading: 'Delete Requests',
        breadcrumbsItems: [BreadcrumbItem(title: 'Delete Requests')],
      ),
      toolbar: AdminTableToolbar(
        search: TableSearchField(
          controller: controller.searchController,
          hint: 'Search delete requests...',
          onSearchChanged: controller.onSearchChanged,
        ),
      ),
      body: Obx(
        () => AppPaginatedTable<DeleteRequestModel>(
          columns: const [
            AppTableColumn(title: 'No', width: 60),
            AppTableColumn(title: 'Name'),
            AppTableColumn(title: 'Email'),
            AppTableColumn(title: 'Status', width: 120),
            AppTableColumn(title: 'Actions', width: 100),
          ],
          rows: controller.deleteRequests,
          totalRows: controller.total.value,
          rowsPerPage: controller.rowsPerPage.value,
          isLoading: controller.isLoading.value,
          onPageChanged: controller.onPageChange,
          onRefresh: controller.fetchDeleteRequests,
          rowBuilder: (request, index) {
            return DataRow(
              color: TableHelpers.rowHoverColor(),
              cells: [
                DataCell(Text((index + 1).toString())),
                DataCell(
                  Text(
                    request.userId.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorConst.primary,
                    ),
                  ),
                ),
                DataCell(Text(request.userId.email)),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: request.status == "pending"
                          ? Colors.orange.withOpacity(0.1)
                          : Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      request.status.capitalizeFirst!,
                      style: TextStyle(
                        color: request.status == "pending"
                            ? Colors.orange
                            : Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      tableActionIconButton(
                        icon: Icons.check,
                        color: Colors.green,
                        onTap: () {
                          controller.updateDeleteRequestStatus(
                            request.id,
                            "approved",
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      tableActionIconButton(
                        icon: AppIcons.delete,
                        color: Colors.red,
                        onTap: () {
                          controller.deleteDeleteRequest(request.id);
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
