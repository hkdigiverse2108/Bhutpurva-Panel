import 'package:bhutpurva_penal/core/device/device_utility.dart';
import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/form_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/outer_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SecurityTab extends StatelessWidget {
  const SecurityTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    final bool isMobile = DeviceUtility.isMobileScreen(context);

    return Form(
      key: controller.securityFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: isMobile ? double.infinity : 550,
            child: Obx(
              () => AdminFormSectionCard(
                title: "Change Password",
                fields: [
                  OuterLabelTextField(
                    label: 'Current Password',
                    controller: controller.currentPasswordController,
                    prefixIcon: const Icon(Iconsax.lock),
                    obscureText: controller.currentPasswordHidden.value,
                    validator: (value) =>
                        value!.isEmpty ? 'Current password is required' : null,
                    hint: 'Enter current password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.currentPasswordHidden.value
                            ? PhosphorIconsBold.eyeSlash
                            : PhosphorIconsBold.eye,
                      ),
                      onPressed: () {
                        controller.currentPasswordHidden.toggle();
                      },
                    ),
                  ),
                  OuterLabelTextField(
                    label: 'New Password',
                    controller: controller.newPasswordController,
                    prefixIcon: const Icon(PhosphorIconsBold.password),
                    obscureText: controller.newPasswordHidden.value,
                    validator: (value) =>
                        value!.isEmpty ? 'New password is required' : null,
                    hint: 'Enter new password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.newPasswordHidden.value
                            ? PhosphorIconsBold.eyeSlash
                            : PhosphorIconsBold.eye,
                      ),
                      onPressed: () {
                        controller.newPasswordHidden.toggle();
                      },
                    ),
                  ),
                  OuterLabelTextField(
                    label: 'Confirm Password',
                    controller: controller.confirmPasswordController,
                    prefixIcon: const Icon(PhosphorIconsBold.password),
                    obscureText: controller.confirmPasswordHidden.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm password is required';
                      }
                      return null;
                    },
                    hint: 'Confirm new password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.confirmPasswordHidden.value
                            ? PhosphorIconsBold.eyeSlash
                            : PhosphorIconsBold.eye,
                      ),
                      onPressed: () {
                        controller.confirmPasswordHidden.toggle();
                      },
                    ),
                  ),
                  const Gap(16),
                  Obx(
                    () => AdminFormButton(
                      onPressed: controller.updatePassword,
                      isLoading: controller.isSettingsUpdateLoading.value,
                      label: 'Change Password',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
