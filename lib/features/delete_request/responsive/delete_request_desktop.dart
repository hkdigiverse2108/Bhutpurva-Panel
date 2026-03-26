import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/delete_request/controllers/delete_request_controller.dart';
import 'package:bhutpurva_penal/features/delete_request/delete_request.dart';
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
        // actions: [
        //   TableActionButton(
        //     label: 'Add Delete Request',
        //     onTap: controller.onCreateProgram,
        //     icon: Icons.add,
        //     color: ColorConst.primary,
        //   ),
        // ],
      ),
      body: Obx(
        () => AppPaginatedTable<DeleteRequestModel>(
          columns: const [
            AppTableColumn(title: 'Name'),
            AppTableColumn(title: 'Email'),
            AppTableColumn(title: 'Actions', width: 100),
          ],
          rows: controller.deleteRequest,
          totalRows: controller.total.value,
          rowsPerPage: controller.rowsPerPage.value,
          isLoading: controller.isLoading.value,
          onPageChanged: controller.onPageChange,
          onRefresh: controller.fetchDeleteRequests,
          rowBuilder: (deleteRequest, index) {
            return DataRow(
              cells: [
                DataCell(
                  InkWell(
                    child: Text(
                      "",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ColorConst.primary,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Text("", style: TextStyle(fontWeight: FontWeight.w600)),
                ),

                DataCell(
                  Row(
                    children: [
                      const SizedBox(width: 6),
                      tableActionIconButton(
                        icon: AppIcons.delete,
                        color: Colors.red,
                        onTap: () {
                          controller.fetchDeleteRequests();
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
