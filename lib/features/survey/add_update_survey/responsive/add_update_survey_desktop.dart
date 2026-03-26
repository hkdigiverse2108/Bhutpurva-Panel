import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/features/survey/add_update_survey/controllers/add_update_survey_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/form_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_from_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/outer_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddUpdateSurveyDesktop extends GetView<AddUpdateSurveyController> {
  const AddUpdateSurveyDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminFormPageLayout(
      header: Obx(() => BreadcrumbWithHeading(
        heading: controller.isEditMode.value ? 'Edit Survey' : 'Create Survey',
        breadcrumbsItems: [
          BreadcrumbItem(title: 'Surveys'),
          BreadcrumbItem(title: controller.isEditMode.value ? 'Edit Survey' : 'Create Survey'),
        ],
      )),
      body: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(SizeConst.defaultSpace),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(SizeConst.borderRadiusLg),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Survey Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: SizeConst.spaceBtwItems),
                  OuterLabelTextField(
                    controller: controller.titleController,
                    label: 'Title',
                    hint: 'Enter survey title',
                    validator: (v) => v!.isEmpty ? 'Title is required' : null,
                  ),
                  const SizedBox(height: SizeConst.spaceBtwItems),
                  OuterLabelTextField(
                    controller: controller.descriptionController,
                    label: 'Description',
                    hint: 'Enter survey description',
                    maxLines: 3,
                  ),
                  const SizedBox(height: SizeConst.spaceBtwItems),
                  
                  Obx(() => Row(
                    children: [
                      Expanded(
                        child: AdminSearchSelectField(
                          label: 'Scope',
                          hint: 'Select Scope',
                          value: controller.scopeValue.value,
                          items: [
                            AdminDropdownItem(value: 'overall', label: 'Overall'),
                            AdminDropdownItem(value: 'group', label: 'Group'),
                            AdminDropdownItem(value: 'batch', label: 'Batch'),
                          ],
                          onChanged: controller.onScopeChanged,
                        ),
                      ),
                      if (controller.scopeValue.value == 'group') ...[
                        const SizedBox(width: SizeConst.spaceBtwItems),
                        Expanded(
                          child: AdminSearchSelectField(
                            label: 'Select Group',
                            hint: 'Select Group',
                            value: controller.selectedGroupId.value,
                            items: controller.groups
                                .map((e) => AdminDropdownItem(value: e.id, label: e.name))
                                .toList(),
                            onChanged: (v) => controller.selectedGroupId.value = v,
                          ),
                        ),
                      ],
                      if (controller.scopeValue.value == 'batch') ...[
                        const SizedBox(width: SizeConst.spaceBtwItems),
                        Expanded(
                          child: AdminSearchSelectField(
                            label: 'Select Batch',
                            hint: 'Select Batch',
                            value: controller.selectedBatchId.value,
                            items: controller.batches
                                .map((e) => AdminDropdownItem(value: e.id, label: e.name))
                                .toList(),
                            onChanged: (v) => controller.selectedBatchId.value = v,
                          ),
                        ),
                      ],
                    ],
                  )),
                ],
              ),
            ),
            const SizedBox(height: SizeConst.spaceBtwSections),
            
            // Survey Builder Section
            Container(
              padding: const EdgeInsets.all(SizeConst.defaultSpace),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(SizeConst.borderRadiusLg),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      AdminFormButton(
                        onPressed: controller.addQuestion,
                        icon: Iconsax.add,
                        label: 'Add Question',
                        variant: AdminButtonVariant.secondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: SizeConst.spaceBtwItems),
                  
                  Obx(() => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.questions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: SizeConst.spaceBtwItems),
                    itemBuilder: (context, index) {
                      final q = controller.questions[index];
                      return Container(
                        padding: const EdgeInsets.all(SizeConst.defaultSpace),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(SizeConst.borderRadiusLg),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Question ${index + 1}',
                                      border: const OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    initialValue: q.questionText,
                                    onChanged: (val) => controller.updateQuestionText(index, val),
                                    validator: (v) => v!.isEmpty ? 'Required' : null,
                                  ),
                                ),
                                const SizedBox(width: SizeConst.spaceBtwItems),
                                Expanded(
                                  flex: 1,
                                  child: AdminSearchSelectField(
                                    label: 'Type',
                                    hint: 'Select Type',
                                    value: q.questionType,
                                    items: [
                                      AdminDropdownItem(value: 'text', label: 'Short Text'),
                                      AdminDropdownItem(value: 'long_text', label: 'Long Text'),
                                      AdminDropdownItem(value: 'rating', label: 'Rating (1-5)'),
                                      AdminDropdownItem(value: 'single_choice', label: 'Single Choice (Radio)'),
                                      AdminDropdownItem(value: 'multiple_choice', label: 'Multiple Choice (Checkbox)'),
                                      AdminDropdownItem(value: 'dropdown', label: 'Dropdown'),
                                    ],
                                    onChanged: (val) => controller.updateQuestionType(index, val),
                                  ),
                                ),
                                const SizedBox(width: SizeConst.spaceBtwItems),
                                Container(
                                  margin: const EdgeInsets.only(top: 24),
                                  child: IconButton(
                                    onPressed: () => controller.removeQuestion(index),
                                    icon: const Icon(Iconsax.trash, color: Colors.red),
                                    tooltip: 'Remove Question',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Checkbox(
                                  value: q.isRequired,
                                  onChanged: (val) => controller.toggleQuestionRequired(index, val),
                                  activeColor: ColorConst.primary,
                                ),
                                const Text('Required'),
                              ],
                            ),
                            
                            if (['single_choice', 'multiple_choice', 'dropdown'].contains(q.questionType)) ...[
                              const SizedBox(height: 12),
                              const Text('Options:', style: TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              ...List.generate(q.options.length, (optIndex) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Option ${optIndex + 1}',
                                            border: const OutlineInputBorder(),
                                            isDense: true,
                                            contentPadding: const EdgeInsets.all(12),
                                          ),
                                          initialValue: q.options[optIndex],
                                          onChanged: (val) => controller.updateOptionText(index, optIndex, val),
                                          validator: (v) => v!.isEmpty ? 'Required' : null,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => controller.removeOption(index, optIndex),
                                        icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
                                        tooltip: 'Remove Option',
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              TextButton.icon(
                                onPressed: () => controller.addOption(index),
                                icon: const Icon(Iconsax.add, size: 16),
                                label: const Text('Add Option'),
                              )
                            ]
                          ],
                        ),
                      );
                    },
                  ))
                ],
              ),
            ),
            
            const SizedBox(height: SizeConst.spaceBtwSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: SizeConst.spaceBtwItems),
                Obx(() => AdminFormButton(
                  label: controller.isEditMode.value ? 'Update Survey' : 'Save Survey',
                  onPressed: controller.saveSurvey,
                )),
              ],
            ),
            const SizedBox(height: SizeConst.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
