import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/manage_batches/batch_details/controllers/batch_details_controller.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:bhutpurva_penal/shared/models/monitor_model/monitor_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_text_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_toolbar.dart';
import 'package:bhutpurva_penal/shared/widgets/popups/smart_selection_dialog.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_shimmer.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/table_search_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BatchDetailsDesktop extends StatelessWidget {
  const BatchDetailsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BatchDetailsController.instance;
    return Scaffold(
      body: AdminTablePageLayout(
        header: Obx(
          () => BreadcrumbWithHeading(
            heading: '${controller.batch?.name ?? "Batch"} Details',
            returnToPreviousScreen: true,
            breadcrumbsItems: [
              BreadcrumbItem(title: 'Batches', route: AppPages.manageBatches),
              BreadcrumbItem(title: 'Batch Details'),
            ],
          ),
        ),
        toolbar: AdminTableToolbar(
          search: TableSearchField(
            controller: controller.searchController,
            hint: 'Search Batch...',
            onSearchChanged: controller.onSearchChanged,
          ),
          actions: [
            Obx(
              () => (controller.tab.value == 0)
                  ? TableActionButton(
                      onTap: () {
                        controller.tab.value = 1;
                      },
                      label: 'Monitors',
                      icon: PhosphorIconsBold.userCircleGear,
                      color: ColorConst.primary,
                    )
                  : TableActionButton(
                      onTap: () {
                        controller.tab.value = 0;
                      },
                      label: 'All Students',
                      icon: PhosphorIconsBold.users,
                      color: ColorConst.primary,
                    ),
            ),
          ],
        ),
        body: Obx(() {
          Widget child;

          if (controller.tab.value == 0) {
            if (controller.isBatchLoading.value) {
              child = const AppTableShimmer(
                key: ValueKey('student_shimmer'),
                columnWidths: [60, null, null, null, 120, 140],
              );
            } else {
              child = AppPaginatedTable(
                key: const ValueKey('students_table'),
                columns: const [
                  AppTableColumn(title: 'No', width: 60),
                  AppTableColumn(title: 'Student Name'),
                  // AppTableColumn(title: 'Group'),
                  AppTableColumn(title: 'Mobile Number'),
                  AppTableColumn(title: 'City'),
                  AppTableColumn(title: 'Status', width: 120),
                  AppTableColumn(title: 'Actions', width: 200),
                ],
                rows: controller.devotees,
                totalRows: controller.totalDevotees.value,
                rowsPerPage: controller.rowsPerPage,
                onPageChanged: controller.onPageChange,
                checkboxColumn: true,
                rowBuilder: (item, index) {
                  return DataRow(
                    color: TableHelpers.rowHoverColor(),
                    cells: [
                      DataCell(Text((index + 1).toString())),
                      DataCell(Text(item.name)),
                      // DataCell(Text(item.groupId?.name ?? "-")),
                      DataCell(Text(item.phoneNumber)),
                      DataCell(
                        Text(
                          item.addressIds.isNotEmpty
                              ? item.addressIds.first.city
                              : 'N/A',
                        ),
                      ),
                      DataCell(
                        Text(item.isVerified ? 'Verified' : 'Not Verified'),
                      ),
                      DataCell(
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              tableActionIconButton(
                                icon: PhosphorIconsBold.pencilSimpleLine,
                                onTap: () {
                                  controller.onEditStudent(item);
                                },
                                color: ColorConst.primary,
                              ),
                              if (!controller.isBatchLoading.value &&
                                  !controller.isMonitorLoading.value &&
                                  !controller.monitors.any(
                                    (m) => m.userId.id == item.id,
                                  )) ...[
                                const Gap(6),
                                TextButton(
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text('Promote to Monitor'),
                                        content: const Text(
                                          'Are you sure you want to promote this student to monitor?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                              controller.promoteToMonitor(
                                                item.id,
                                              );
                                            },
                                            child: const Text('Confirm'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: ColorConst.primary
                                        .withValues(alpha: 0.1),
                                    foregroundColor: ColorConst.primary,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    'Promote',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          } else {
            if (controller.isBatchLoading.value) {
              child = const AppTableShimmer(
                key: ValueKey('monitor_shimmer'),
                columnWidths: [60, null, null, null, 120, 160],
              );
            } else {
              child = AppPaginatedTable(
                key: const ValueKey('monitor_table'),
                columns: const [
                  AppTableColumn(title: 'No', width: 60),
                  AppTableColumn(title: 'Monitor Name'),
                  AppTableColumn(title: 'Mobile Number'),
                  AppTableColumn(title: 'Status', width: 120),
                  AppTableColumn(title: 'Actions', width: 200),
                ],
                rows: controller.monitors,
                totalRows: controller.totalMonitors.value,
                rowsPerPage: controller.rowsPerPage,
                onPageChanged: controller.onPageChange,
                checkboxColumn: true,
                rowBuilder: (MonitorModel item, index) {
                  return DataRow(
                    color: TableHelpers.rowHoverColor(),
                    cells: [
                      DataCell(Text((index + 1).toString())),
                      DataCell(Text(item.userId.name)),
                      DataCell(Text(item.userId.phoneNumber)),
                      DataCell(Text(item.status.capitalizeFirst ?? "-")),
                      DataCell(
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              tableActionTextButton(
                                text: 'Assign',
                                onTap: () {
                                  final existingDevotees = controller.devotees
                                      .where((e) => item.devoteeIds.contains(e.id))
                                      .toList()
                                      .obs;

                                  controller.selectedAlumni.clear();
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return SmartSelectionDialog<StudentModel>(
                                        title: 'Assign Members',
                                        existingItems: existingDevotees,
                                        onRemoveExisting: (devotee) {
                                          controller.unassignDevotee(
                                            item.id,
                                            devotee.id,
                                          );
                                          existingDevotees.remove(devotee);
                                        },
                                        onDone: () {
                                          if (controller
                                              .selectedAlumni
                                              .isNotEmpty) {
                                            controller.assignDevotees(
                                              item.id,
                                              controller.selectedAlumni
                                                  .map((e) => e.id)
                                                  .toList(),
                                            );
                                          }
                                          Get.back();
                                        },
                                        searchWidget: Obx(
                                          () =>
                                              AdminSearchSelectField<
                                                StudentModel
                                              >(
                                                label: 'Student',
                                                items: controller.allAlumni
                                                    .where(
                                                      (a) =>
                                                          !existingDevotees.any(
                                                            (e) => e.id == a.id,
                                                          ),
                                                    )
                                                    .map(
                                                      (e) => AdminDropdownItem(
                                                        value: e,
                                                        label: e.name,
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (value) {
                                                  if (value == null) return;

                                                  if (!controller.selectedAlumni
                                                      .contains(value)) {
                                                    controller.selectedAlumni
                                                        .add(value);
                                                  }
                                                },
                                              ),
                                        ),
                                        onRemove: (item) {
                                          controller.selectedAlumni.remove(
                                            item,
                                          );
                                        },
                                        itemBuilder:
                                            (context, StudentModel item) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 10,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Colors.grey.shade200,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    /// Avatar / Initial
                                                    CircleAvatar(
                                                      radius: 16,
                                                      backgroundColor:
                                                          Colors.blue.shade50,
                                                      child: Text(
                                                        item.name.isNotEmpty
                                                            ? item.name[0]
                                                                  .toUpperCase()
                                                            : '?',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),

                                                    const SizedBox(width: 12),

                                                    /// Name
                                                    Expanded(
                                                      child: Text(
                                                        item.name,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                        selectedItems:
                                            controller.selectedAlumni,
                                      );
                                    },
                                  );
                                },
                                textColor: ColorConst.primary,
                                backgroundColor: ColorConst.primary.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                              const Gap(8),
                              tableActionIconButton(
                                icon: PhosphorIconsBold.eye,
                                onTap: () {},
                                color: ColorConst.info,
                              ),
                              const Gap(8),
                              tableActionIconButton(
                                icon: PhosphorIconsBold.trash,
                                onTap: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: const Text('Remove Monitor'),
                                      content: const Text(
                                        'Are you sure you want to remove this monitor?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                            controller.removeMonitor(item.id);
                                          },
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                color: ColorConst.error,
                              ),
                            ],
                          ),
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
