import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/manage_groups/create_group/controllers/create_group_controller.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
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

class CreateGroupDesktop extends StatelessWidget {
  const CreateGroupDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateGroupController.instance;
    return Scaffold(
      body: SizedBox(
        width: 600,
        child: AdminFormPageLayout(
          header: const BreadcrumbWithHeading(
            heading: 'Create Group',
            returnToPreviousScreen: true,
            breadcrumbsItems: [
              BreadcrumbItem(title: 'Groups', route: AppPages.manageGroups),
              BreadcrumbItem(title: 'Create Group'),
            ],
          ),
          body: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdminFormSectionCard(
                  title: 'Group Details',
                  fields: [
                    TextFormField(
                      controller: controller.nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Group Name',
                        hintText: "Enter Group Name",
                        prefixIcon: const Icon(
                          PhosphorIconsBold.usersThree,
                          fill: 0.0,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Group name is required';
                        }
                        return null;
                      },
                    ),

                    Obx(
                      () => AdminSearchSelectField<UserModel>(
                        label: 'Select Leaders',
                        hint: 'Search leader',
                        prefixIcon: PhosphorIconsBold.user,
                        isLoading: controller.isLeadersLoading.value,
                        items: controller.leaders
                            .map(
                              (e) => AdminDropdownItem(value: e, label: e.name),
                            )
                            .toList(),
                        onChanged: (leader) {
                          if (leader == null) return;

                          if (!controller.selectedLeaders.contains(leader)) {
                            controller.selectedLeaders.add(leader);
                          }
                        },
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: controller.selectedLeaders.map((leader) {
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
                                      leader.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.selectedLeaders.remove(leader);
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
                const Gap(SizeConst.spaceBtwInputFields),
                AdminFormSectionCard(
                  title: 'Batches',
                  fields: [
                    Obx(
                      () => AdminSearchSelectField<BatchesModel>(
                        label: 'Select Batches',
                        hint: 'Search Batches',
                        prefixIcon: PhosphorIconsBold.user,
                        isLoading: controller.isBatchesLoading.value,
                        items: controller.batches
                            .map(
                              (e) => AdminDropdownItem(value: e, label: e.name),
                            )
                            .toList(),
                        onChanged: (batch) {
                          if (batch == null) return;

                          if (!controller.selectedBatches.contains(batch)) {
                            controller.selectedBatches.add(batch);
                          }
                        },
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: controller.selectedBatches.map((batch) {
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
                                      batch.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.selectedBatches.remove(batch);
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
                const Gap(SizeConst.spaceBtwInputFields),
                LayoutBuilder(
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
                            onPressed: controller.createGroup,
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
                            onPressed: controller.createGroup,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
