import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/outer_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppTab extends StatelessWidget {
  const AppTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Form(
      key: controller.appFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 550,
            child: AdminFormSectionCard(
              title: "App Settings",
              fields: [
                OuterLabelTextField(
                  label: 'App Url',
                  controller: controller.appUrlController,
                  prefixIcon: const Icon(Iconsax.link),
                  hint: 'https://example.com',
                ),
                OuterLabelTextField(
                  label: 'PlayStore Url',
                  controller: controller.playStoreUrlController,
                  prefixIcon: const Icon(PhosphorIconsBold.googlePlayLogo),
                  hint: 'https://example.com',
                ),
                OuterLabelTextField(
                  label: 'AppStore Url',
                  controller: controller.appStoreUrlController,
                  prefixIcon: const Icon(PhosphorIconsBold.appStoreLogo),
                  hint: 'https://example.com',
                ),
                OuterLabelTextField(
                  label: 'About App',
                  controller: controller.aboutAppController,
                  maxLines: 8,
                  hint: 'Enter about app details here...',
                ),
                Gap(1),
                ElevatedButton(onPressed: () {}, child: const Text('Update')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
