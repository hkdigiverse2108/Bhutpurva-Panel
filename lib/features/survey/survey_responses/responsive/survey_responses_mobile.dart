import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/survey/survey_responses/controllers/survey_responses_controller.dart';
import 'package:bhutpurva_penal/features/survey/survey_responses/views/survey_response_detail_view.dart';
import 'package:bhutpurva_penal/shared/models/survey_models/survey_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class SurveyResponsesMobile extends GetView<SurveyResponsesController> {
  const SurveyResponsesMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.surveyTitle.value)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SizeConst.md, vertical: SizeConst.sm),
            child: Row(
              children: [
                const Icon(Iconsax.info_circle, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Showing responses list',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.fetchResponses(),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.responses.isEmpty) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.document_text, size: 64, color: Colors.grey),
                      const SizedBox(height: SizeConst.spaceBtwItems),
                      const Text(
                        'No responses found for this survey yet.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
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

          return ListView.builder(
            padding: const EdgeInsets.all(SizeConst.defaultSpace),
            itemCount: controller.responses.length,
            itemBuilder: (context, index) {
              final item = controller.responses[index];
              return _buildResponseCard(context, item);
            },
          );
        }),
      ),
    );
  }

  Widget _buildResponseCard(BuildContext context, SurveyResponseModel item) {
    final userName = item.userId != null
        ? '${item.userId?.name ?? ''} ${item.userId?.surname ?? ''}'.trim()
        : 'Unknown User';
    final submittedDate = item.createdAt != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt!)
        : '-';

    return Card(
      margin: const EdgeInsets.only(bottom: SizeConst.spaceBtwItems),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConst.borderRadiusLg),
        side: BorderSide(color: Colors.grey.withOpacity(0.1)),
      ),
      child: InkWell(
        onTap: () => _showResponseDetail(item, userName),
        borderRadius: BorderRadius.circular(SizeConst.borderRadiusLg),
        child: Padding(
          padding: const EdgeInsets.all(SizeConst.md),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Icon(Iconsax.user, size: 20, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(width: SizeConst.spaceBtwItems),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName.isNotEmpty ? userName : 'Unknown User',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Submitted: $submittedDate',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Iconsax.arrow_right_3, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showResponseDetail(SurveyResponseModel response, String userName) {
    // Reuse existing controller for the detail page
    Get.to(
      () => SurveyResponseDetailView(response: response, userName: userName),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => Get.find<SurveyResponsesController>());
      }),
    );
  }
}
