import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/programs/program_details/controllers/program_detail_controller.dart';
import 'package:bhutpurva_penal/shared/models/attendense_models/attendense_models.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';

import 'package:bhutpurva_penal/shared/widgets/icons/icons.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProgramDetailDesktop extends StatelessWidget {
  const ProgramDetailDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProgramDetailController.instance;

    return AdminTablePageLayout(
      header: const BreadcrumbWithHeading(
        heading: 'Attendence',
        breadcrumbsItems: [BreadcrumbItem(title: 'Attendence')],
      ),
      toolbar: AdminTableToolbar(
        search: TableSearchField(
          controller: controller.searchController,
          hint: 'Search Attendence...',
          onSearchChanged: controller.onSearchChanged,
        ),
        actions: const [],
      ),
      body: Obx(
        () => AppPaginatedTable<AttendanceModel>(
          columns: const [
            AppTableColumn(title: 'Name'),
            AppTableColumn(title: 'Batch'),
            AppTableColumn(title: 'Date'),
            AppTableColumn(title: 'Actions', width: 100),
          ],
          rows: controller.attendances,
          totalRows: controller.total.value,
          rowsPerPage: controller.rowsPerPage.value,
          isLoading: controller.isLoading.value,
          onPageChanged: controller.onPageChange,
          onRefresh: controller.fetchAttendance,

          rowBuilder: (program, index) {
            return DataRow(
              cells: [
                DataCell(
                  InkWell(
                    child: Text(
                      program.programId.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ColorConst.primary,
                      ),
                    ),
                  ),
                ),
                DataCell(Text(program.batchId.name)),
                // DataCell(
                //   Tooltip(
                //     message: program.studentId.name,
                //     child: Text(
                //       program.studentId.name,
                //       maxLines: 1,
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //   ),
                // ),
                DataCell(Text(DateFormat('dd MMM yyyy').format(program.date))),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          AppIcons.edit,
                          size: 20,
                          color: ColorConst.primary,
                        ),
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
