import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/feedback/controllers/feedback_controller.dart';
import 'package:bhutpurva_penal/shared/models/feedback_models/feedback_model.dart';
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
import 'package:intl/intl.dart';

class FeedbackDesktop extends StatelessWidget {
  const FeedbackDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FeedbackController.instance;

    return Scaffold(
      body: AdminTablePageLayout(
        header: BreadcrumbWithHeading(
          heading: 'FeedBack',
          breadcrumbsItems: [BreadcrumbItem(title: 'FeedBack')],
        ),
        toolbar: AdminTableToolbar(
          search: TableSearchField(
            controller: controller.searchController,
            hint: 'Search Group...',
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
          return AppPaginatedTable<FeedbackModel>(
            columns: [
              AppTableColumn(title: 'No', width: 60),
              AppTableColumn(title: 'Name'),
              AppTableColumn(title: 'Email'),
              AppTableColumn(title: 'Feedback'),
              AppTableColumn(title: 'Created At', width: 120),
              AppTableColumn(title: 'Action', width: 140),
            ],
            rows: controller.feedbacks,
            rowsPerPage: 10,
            onPageChanged: (page) {},
            rowBuilder: (item, index) {
              return DataRow(
                color: TableHelpers.rowHoverColor(),
                cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(item.name)),
                  DataCell(Text(item.email)),
                  DataCell(Text(item.feedback)),
                  DataCell(
                    Text(
                      DateFormat(
                        'dd, MMM yyyy',
                      ).format(DateTime.parse(item.createdAt)),
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        tableActionIconButton(
                          icon: Iconsax.trash,
                          onTap: () {},
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
      ),
    );
  }
}
