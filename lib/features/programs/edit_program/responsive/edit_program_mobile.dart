import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/programs/edit_program/controllers/edit_program_controller.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/form_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_from_page_layout.dart';
import 'package:bhutpurva_penal/shared/widgets/loaders/app_full_screen_loader.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';

class EditProgramMobile extends StatelessWidget {
  const EditProgramMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditProgramController.instance;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Obx(
        () => AppFullScreenLoader(
          isLoading: controller.isLoading.value,
          child: AdminFormPageLayout(
            header: const BreadcrumbWithHeading(
              heading: 'Edit Program',
              returnToPreviousScreen: true,
              breadcrumbsItems: [
                BreadcrumbItem(
                  title: 'Programs',
                  route: AppPages.managePrograms,
                ),
                BreadcrumbItem(title: 'Edit Program'),
              ],
            ),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  AdminFormSectionCard(
                    title: 'Program Details',
                    fields: [
                      TextFormField(
                        controller: controller.nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Program Name',
                          hintText: "Enter Program Name",
                          prefixIcon: Icon(PhosphorIconsBold.calendar),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Program name is required'
                                : null,
                      ),
                      Obx(
                        () => AdminSearchSelectField<BatchDropdownModel>(
                          label: 'Select Batch',
                          hint: 'Search Batch',
                          prefixIcon: PhosphorIconsBold.books,
                          isLoading: controller.isBatchesLoading.value,
                          value: controller.selectedBatch.value,
                          items: controller.batches
                              .map((e) => AdminDropdownItem(
                                  value: e, label: e.name))
                              .toList(),
                          onChanged: (batch) =>
                              controller.selectedBatch.value = batch,
                        ),
                      ),
                      TextFormField(
                        controller: controller.dateController,
                        readOnly: true,
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            controller.dateController.text =
                                DateFormat('yyyy-MM-dd').format(picked);
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Date',
                          hintText: "Select Date",
                          prefixIcon: Icon(PhosphorIconsBold.calendarBlank),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Date is required'
                                : null,
                      ),
                      TextFormField(
                        controller: controller.descriptionController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: "Enter Description",
                          prefixIcon: Icon(PhosphorIconsBold.article),
                          alignLabelWithHint: true,
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Description is required'
                                : null,
                      ),
                    ],
                  ),
                  const Gap(SizeConst.spaceBtwSections),
                  AdminFormButton(
                    label: 'Update Program',
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.updateProgram();
                      }
                    },
                  ),
                  const Gap(12),
                  AdminFormButton(
                    label: 'Cancel',
                    variant: AdminButtonVariant.secondary,
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
