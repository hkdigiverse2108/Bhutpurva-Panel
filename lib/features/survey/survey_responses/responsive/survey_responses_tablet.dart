import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/core/helpers/table_helpers.dart';
import 'package:bhutpurva_penal/features/survey/survey_responses/controllers/survey_responses_controller.dart';
import 'package:bhutpurva_penal/shared/models/survey_models/survey_response_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_icon_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_table_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_paginated_table.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_columns.dart';
import 'package:bhutpurva_penal/shared/widgets/tables/app_table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class SurveyResponsesTablet extends GetView<SurveyResponsesController> {
  const SurveyResponsesTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminTablePageLayout(
      header: Obx(
        () => BreadcrumbWithHeading(
          heading: controller.surveyTitle.value,
          breadcrumbsItems: [
            BreadcrumbItem(title: 'Surveys', route: AppPages.manageSurveys),
            BreadcrumbItem(title: 'Responses'),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.fetchResponses(),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const AppTableShimmer(columnWidths: [60, null, 150, 100]);
          }
          if (controller.responses.isEmpty) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.document_text, size: 64, color: Colors.grey),
                      const SizedBox(height: SizeConst.spaceBtwItems),
                      const Text(
                        'No responses found for this survey yet.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: SizeConst.spaceBtwItems),
                      ElevatedButton(
                        onPressed: () => controller.fetchResponses(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return AppPaginatedTable<SurveyResponseModel>(
            columns: const [
              AppTableColumn(title: 'No', width: 60),
              AppTableColumn(title: 'Participant Name'),
              AppTableColumn(title: 'Submitted At', width: 150),
              AppTableColumn(title: 'Action', width: 100),
            ],
            rows: controller.responses,
            totalRows: controller.total,
            rowsPerPage: controller.rowsPerPage,
            onPageChanged: controller.onPageChange,
            rowBuilder: (item, index) {
              final userName = item.userId != null
                  ? '${item.userId?.name ?? ''} ${item.userId?.surname ?? ''}'
                        .trim()
                  : 'Unknown User';
              final submittedDate = item.createdAt != null
                  ? DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt!)
                  : '-';

              return DataRow(
                color: TableHelpers.rowHoverColor(),
                cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(userName.isNotEmpty ? userName : 'Unknown User')),
                  DataCell(Text(submittedDate)),
                  DataCell(
                    tableActionIconButton(
                      icon: Iconsax.eye,
                      onTap: () => _showResponseDetails(context, item, userName),
                      color: Colors.blue,
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

  void _showResponseDetails(
    BuildContext context,
    SurveyResponseModel response,
    String userName,
  ) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConst.borderRadiusLg),
        ),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(SizeConst.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Response by $userName',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Iconsax.close_circle),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: SizeConst.spaceBtwItems),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: response.answers.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: SizeConst.spaceBtwItems),
                  itemBuilder: (context, index) {
                    final ans = response.answers[index];
                    final questionText = controller.getQuestionText(
                      ans.questionId,
                    );

                    String displayAnswer = '';
                    if (ans.answer is List) {
                      displayAnswer = (ans.answer as List).join(', ');
                    } else {
                      displayAnswer = ans.answer?.toString() ?? 'No Answer';
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Q: $questionText',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'A: $displayAnswer',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
