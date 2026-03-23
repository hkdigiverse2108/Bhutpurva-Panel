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

class OtherTab extends StatelessWidget {
  const OtherTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    final bool isMobile = DeviceUtility.isMobileScreen(context);

    return Form(
      key: controller.otherFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: isMobile ? double.infinity : 550,
            child: AdminFormSectionCard(
              title: "Support Settings",
              fields: [
                OuterLabelTextField(
                  label: 'Support Phone',
                  controller: controller.supportPhoneController,
                  prefixIcon: const Icon(Iconsax.call),
                  keyboardType: TextInputType.number,
                  hint: '9876543210',
                ),
                OuterLabelTextField(
                  label: 'Support WhatsApp',
                  controller: controller.supportWhatsAppController,
                  prefixIcon: const Icon(PhosphorIconsBold.whatsappLogo),
                  keyboardType: TextInputType.number,
                  hint: '9876543210',
                ),
                OuterLabelTextField(
                  label: 'Support Email',
                  controller: controller.supportEmailController,
                  prefixIcon: const Icon(PhosphorIconsBold.paperPlaneRight),
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Support@domain.com',
                ),
              ],
            ),
          ),
          const Gap(16),
          SizedBox(
            width: isMobile ? double.infinity : 550,
            child: AdminFormSectionCard(
              title: "Social Links",
              fields: [
                OuterLabelTextField(
                  label: 'Facebook',
                  controller: controller.facebookController,
                  prefixIcon: const Icon(PhosphorIconsBold.facebookLogo),
                  hint: 'https://facebook.com/example',
                ),
                OuterLabelTextField(
                  label: 'Instagram',
                  controller: controller.instagramController,
                  prefixIcon: const Icon(PhosphorIconsBold.instagramLogo),
                  hint: 'https://instagram.com/example',
                ),
                OuterLabelTextField(
                  label: 'Twitter',
                  controller: controller.twitterController,
                  prefixIcon: const Icon(PhosphorIconsBold.twitterLogo),
                  hint: 'https://twitter.com/example',
                ),
                OuterLabelTextField(
                  label: 'LinkedIn',
                  controller: controller.linkedinController,
                  prefixIcon: const Icon(PhosphorIconsBold.linkedinLogo),
                  hint: 'https://linkedin.com/company/example',
                ),
                OuterLabelTextField(
                  label: 'YouTube',
                  controller: controller.youtubeController,
                  prefixIcon: const Icon(PhosphorIconsBold.youtubeLogo),
                  hint: 'https://youtube.com/example',
                ),
                const Gap(16),
                Obx(
                  () => AdminFormButton(
                    onPressed: controller.updateOther,
                    isLoading: controller.isSettingsUpdateLoading.value,
                    label: 'Update Settings',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
