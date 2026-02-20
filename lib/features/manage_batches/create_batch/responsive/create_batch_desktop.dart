import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/manage_batches/create_batch/controllers/create_batch_controller.dart';
import 'package:bhutpurva_penal/shared/models/devotee_model/devotee_model.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/form_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_from_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateBatchDesktop extends StatelessWidget {
  const CreateBatchDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateBatchController.instance;
    return Scaffold(
      body: AdminFormPageLayout(
        header: const BreadcrumbWithHeading(
          heading: 'Create Batch',
          returnToPreviousScreen: true,
          breadcrumbsItems: [
            BreadcrumbItem(title: 'Batches', route: AppPages.manageBatches),
            BreadcrumbItem(title: 'Create Batch'),
          ],
        ),
        body: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 550,
                child: AdminFormSectionCard(
                  title: 'Batch Details',
                  fields: [
                    TextFormField(
                      controller: controller.nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Batch Name',
                        hintText: "Enter Batch Name",
                        prefixIcon: const Icon(
                          PhosphorIconsBold.users,
                          fill: 0.0,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Batch name is required';
                        }
                        return null;
                      },
                    ),
                    Obx(
                      () => AdminSearchSelectField<DevoteeModel>(
                        label: 'Select Devotees',
                        items: controller.devotees
                            .map(
                              (e) => AdminDropdownItem(value: e, label: e.name),
                            )
                            .toList(),
                        onChanged: (devotee) {
                          if (devotee == null) return;

                          if (!controller.selectedDevotees.contains(devotee)) {
                            controller.selectedDevotees.add(devotee);
                          }
                        },
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: controller.selectedDevotees.map((devotee) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConst.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      devotee.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.selectedDevotees.remove(
                                        devotee,
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Icon(
                                        PhosphorIconsBold.trash,
                                        size: 16,
                                        color: ColorConst.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(SizeConst.spaceBtwInputFields),
              SizedBox(
                width: 550,
                child: AdminFormSectionCard(
                  title: 'Batch Students',
                  fields: [
                    Obx(
                      () => AdminSearchSelectField<StudentModel>(
                        label: 'Select Students',
                        items: controller.students
                            .map(
                              (e) => AdminDropdownItem(value: e, label: e.name),
                            )
                            .toList(),
                        onChanged: (student) {
                          if (student == null) return;

                          if (!controller.selectedStudents.contains(student)) {
                            controller.selectedStudents.add(student);
                          }
                        },
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: controller.selectedStudents.map((student) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConst.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      student.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.selectedStudents.remove(
                                        student,
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Icon(
                                        PhosphorIconsBold.trash,
                                        size: 16,
                                        color: ColorConst.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(SizeConst.spaceBtwInputFields),
              SizedBox(
                width: 550,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile =
                        constraints.maxWidth < SizeConst.mobileScreenSize;

                    if (isMobile) {
                      return Column(
                        children: [
                          AdminFormButton(
                            label: 'Cancel',
                            variant: AdminButtonVariant.secondary,
                            onPressed: () => Get.back(),
                          ),
                          const SizedBox(height: 12),
                          AdminFormButton(
                            label: 'Create Group',
                            isLoading: controller.isLoading.value,
                            onPressed: controller.createBatch,
                          ),
                        ],
                      );
                    }

                    // Desktop / Tablet
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 150,
                          child: AdminFormButton(
                            label: 'Cancel',
                            variant: AdminButtonVariant.secondary,
                            onPressed: () => Get.back(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 150,
                          child: AdminFormButton(
                            label: 'Create Group',
                            isLoading: controller.isLoading.value,
                            onPressed: controller.createBatch,
                          ),
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
