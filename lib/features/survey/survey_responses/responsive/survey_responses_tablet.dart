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
          heading: controller.surveyDetails.value != null
              ? 'Responses: ${controller.surveyDetails.value!.title}'
              : 'Survey Responses',
          breadcrumbsItems: [
            BreadcrumbItem(title: 'Surveys', route: '/surveys'),
            BreadcrumbItem(title: 'Responses'),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppTableShimmer(columnWidths: [40, null, 100, 80]);
        }
        if (controller.responses.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(48.0),
              child: Text('No responses found for this survey yet.'),
            ),
          );
        }
        return AppPaginatedTable<SurveyResponseModel>(
          columns: [
            AppTableColumn(title: 'No', width: 40),
            AppTableColumn(title: 'Participant Name'),
            AppTableColumn(title: 'Submitted At', width: 100),
            AppTableColumn(title: 'Action', width: 80),
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
