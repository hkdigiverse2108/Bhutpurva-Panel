import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/branches/edit_branch/controllers/edit_branch_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb.dart';
import 'package:bhutpurva_penal/shared/widgets/breadcrumbs/breadcrumb_item_model.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/form_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_from_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditBranchDesktop extends StatelessWidget {
  const EditBranchDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBranchController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: AdminFormPageLayout(
        header: const BreadcrumbWithHeading(
          heading: 'Edit Branch',
          returnToPreviousScreen: true,
          breadcrumbsItems: [
            BreadcrumbItem(title: 'Branches', route: AppPages.branches),
            BreadcrumbItem(title: 'Edit Branch'),
          ],
        ),
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 550,
                child: AdminFormSectionCard(
                  title: 'Branch Information',
                  fields: [
                    Obx(
                      () => TextFormField(
                        controller: controller.nameController,
                        keyboardType: TextInputType.name,
                        enabled: !controller.isFetching.value,
                        decoration: const InputDecoration(
                          labelText: 'Branch Name',
                          hintText: "Enter Branch Name",
                          prefixIcon: Icon(PhosphorIconsBold.mapPin, fill: 0.0),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Branch name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Obx(
                      () => SwitchListTile(
                        title: const Text('Active Status'),
                        value: controller.isActive.value,
                        onChanged: controller.isFetching.value
                            ? null
                            : (value) {
                                controller.isActive.value = value;
                              },
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
                            label: 'Update Branch',
                            isLoading: controller.isLoading.value,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.updateBranch();
                              }
                            },
                          ),
                        ],
                      );
                    }

                    // Desktop / Tablet
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AdminFormButton(
                          label: 'Cancel',
                          variant: AdminButtonVariant.secondary,
                          onPressed: () => Get.back(),
                        ),
                        const SizedBox(width: 12),
                        AdminFormButton(
                          label: 'Update Branch',
                          isLoading: controller.isLoading.value,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.updateBranch();
                            }
                          },
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
