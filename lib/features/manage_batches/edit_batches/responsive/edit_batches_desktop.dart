import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/manage_batches/edit_batches/controllers/edit_batch_controller.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/form_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_from_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_multi_search_select_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditBatchDesktop extends StatelessWidget {
  const EditBatchDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditBatchController.instance;
    return Scaffold(
      body: AdminFormPageLayout(
        header: const BreadcrumbWithHeading(
          heading: 'Edit Batch',
          returnToPreviousScreen: true,
          breadcrumbsItems: [
            BreadcrumbItem(title: 'Batches', route: AppPages.manageBatches),
            BreadcrumbItem(title: 'Edit Batch'),
          ],
        ),
        body: Form(
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
                      () => AdminSearchSelectField<GroupDropdownModel>(
                        label: 'Select Group',
                        items: controller.groups
                            .map(
                              (e) => AdminDropdownItem(value: e, label: e.name),
                            )
                            .toList(),
                        onChanged: (group) {
                          if (group == null) return;
                          controller.selectedGroup.value = group;
                        },
                        value: controller.selectedGroup.value,
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
                      () => AdminMultiSearchSelectField<UsersDropdownModel>(
                        label: 'Select Students',
                        items: controller.students
                            .map(
                              (e) => AdminDropdownItem(value: e, label: e.name),
                            )
                            .toList(),
                        selectedItems: controller.selectedStudents,
                        onAdded: (student) {
                          if (!controller.selectedStudents.contains(student)) {
                            controller.selectedStudents.add(student);
                          }
                        },
                        onRemoved: (student) {
                          controller.selectedStudents.remove(student);
                        },
                        itemLabelBuilder: (student) => student.name,
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
                            label: 'Update Batch',
                            isLoading: controller.isSaving.value,
                            onPressed: controller.updateBatch,
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
                            label: 'Update Batch',
                            isLoading: controller.isSaving.value,
                            onPressed: controller.updateBatch,
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
