import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/programs/program_details/controllers/program_detail_controller.dart';
import 'package:bhutpurva_penal/shared/models/attendense_models/attendense_models.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_shimmer.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProgramDetailDesktop extends StatelessWidget {
  const ProgramDetailDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProgramDetailController.instance;

    return Scaffold(
      body: AdminTablePageLayout(
        header: Obx(() {
          final programName = controller.program.isNotEmpty
              ? controller.program.first.name
              : 'Attendance Details';
          return BreadcrumbWithHeading(
            heading: programName,
            breadcrumbsItems: [
              BreadcrumbItem(title: 'Programs', route: AppPages.managePrograms),
              BreadcrumbItem(title: programName),
            ],
            returnToPreviousScreen: true,
          );
        }),
        toolbar: AdminTableToolbar(
          search: TableSearchField(
            controller: controller.searchController,
            hint: 'Search Attendance...',
            onSearchChanged: controller.onSearchChanged,
          ),
          actions: const [],
        ),
        body: Obx(() {
          Widget child;

          // 🔄 LOADING
          if (controller.isLoading.value) {
            child = const AppTableShimmer(
              key: ValueKey('attendance_shimmer'),
              columnWidths: [60, null, null, null],
            );
          }
          // 📭 EMPTY
          else if (controller.attendances.isEmpty) {
            child = const Center(
              key: ValueKey('empty_state'),
              child: Text("No attendance records found"),
            );
          }
          // ✅ MAIN UI
          else {
            final program = controller.program.isNotEmpty
                ? controller.program.first
                : null;

            child = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // 🧾 PROGRAM HEADER
                // =========================
                if (program != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔥 TOP ROW (Name + Date)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              program.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat(
                                'dd MMM yyyy',
                              ).format(program.createdAt),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // 📝 DESCRIPTION
                        Text(
                          program.description ?? '',
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),

                // =========================
                // 📊 TABLE
                // =========================
                Expanded(
                  child: AppPaginatedTable<AttendanceModel>(
                    key: const ValueKey('attendance_table'),
                    columns: const [
                      AppTableColumn(title: 'No', width: 60),
                      AppTableColumn(title: 'Name'),
                      AppTableColumn(title: 'Father Name'),
                      AppTableColumn(title: 'Phone'),
                      AppTableColumn(title: 'Whatsapp'),
                      AppTableColumn(title: 'Date'),
                    ],
                    rows: controller.attendances,
                    totalRows: controller.total.value,
                    rowsPerPage: controller.rowsPerPage.value,
                    onPageChanged: controller.onPageChange,
                    onRefresh: controller.fetchAttendance,
                    rowBuilder: (item, index) {
                      return DataRow(
                        color: TableHelpers.rowHoverColor(),
                        cells: [
                          DataCell(Text((index + 1).toString())),
                          DataCell(Text(item.students.first.studentId.name)),
                          DataCell(
                            Text(item.students.first.studentId.fatherName),
                          ),
                          DataCell(
                            Text(item.students.first.studentId.phoneNumber),
                          ),
                          DataCell(
                            Text(item.students.first.studentId.whatsappNumber),
                          ),
                          DataCell(
                            Text(DateFormat('dd MMM yyyy').format(item.date)),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
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
