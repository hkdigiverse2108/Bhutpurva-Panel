import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/features/location/edit_location/controllers/edit_location_controllers.dart';
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

class EditLocationDesktop extends StatelessWidget {
  const EditLocationDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditLocationController(id: Get.arguments['id']));
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: AdminFormPageLayout(
        header: const BreadcrumbWithHeading(
          heading: 'Edit Location',
          returnToPreviousScreen: true,
          breadcrumbsItems: [
            BreadcrumbItem(title: 'Location', route: AppPages.location),
            BreadcrumbItem(
              title: 'Edit Location',
              route: AppPages.editLocation,
            ),
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
                  title: 'Location Information',
                  fields: [
                    Obx(
                      () => TextFormField(
                        controller: controller.nameController,
                        keyboardType: TextInputType.name,
                        enabled: !controller.isFetching.value,
                        decoration: const InputDecoration(
                          labelText: 'Location Name',
                          hintText: "Enter Location Name",
                          prefixIcon: Icon(PhosphorIconsBold.mapPin, fill: 0.0),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Location name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Obx(
                      () => AdminSearchSelectField<String>(
                        label: 'Select Location Type',
                        isLoading: controller.isFetching.value,
                        value: controller.selectedType.value,
                        items: controller.locationTypes
                            .map((e) => AdminDropdownItem(value: e, label: e))
                            .toList(),
                        onChanged: (type) {
                          if (type == null) return;
                          controller.updateParentLocations(type);
                        },
                      ),
                    ),
                    Obx(
                      () => AdminSearchSelectField<String>(
                        label: 'Select Parent Location',
                        isLoading: controller.isFetching.value ||
                            controller.isParentLocationLoading.value,
                        value: controller.selectedParentLocation.value,
                        items: controller.parentLocationList
                            .map(
                              (e) => AdminDropdownItem(
                                value: e.id,
                                label: e.name,
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          controller.selectedParentLocation.value = val;
                        },
                        enabled: controller.selectedType.value != null &&
                            controller.selectedType.value != "Country",
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
                            label: 'Update Location',
                            isLoading: controller.isLoading.value,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.updateLocation();
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
                          label: 'Update Location',
                          isLoading: controller.isLoading.value,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.updateLocation();
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
