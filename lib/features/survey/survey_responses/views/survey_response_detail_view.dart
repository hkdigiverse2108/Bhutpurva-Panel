import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/survey/survey_responses/controllers/survey_responses_controller.dart';
import 'package:bhutpurva_penal/shared/models/survey_models/survey_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SurveyResponseDetailView extends GetView<SurveyResponsesController> {
  final SurveyResponseModel response;
  final String userName;

  const SurveyResponseDetailView({
    super.key,
    required this.response,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Response: $userName'),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SizeConst.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Survey: ${controller.surveyTitle.value}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
            const SizedBox(height: SizeConst.spaceBtwItems),
            const Divider(),
            const SizedBox(height: SizeConst.spaceBtwItems),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: response.answers.length,
              separatorBuilder: (_, __) => const SizedBox(height: SizeConst.spaceBtwSections),
              itemBuilder: (context, index) {
                final ans = response.answers[index];
                final questionText = controller.getQuestionText(ans.questionId);

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
                      'Question ${index + 1}:',
                      style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      questionText,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(SizeConst.md),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(SizeConst.borderRadiusMd),
                      ),
                      child: Text(
                        displayAnswer,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
