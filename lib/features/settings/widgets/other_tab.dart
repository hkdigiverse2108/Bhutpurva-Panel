import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/outer_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OtherTab extends StatelessWidget {
  const OtherTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Form(
      key: controller.otherFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 550,
            child: AdminFormSectionCard(
              title: "Support Settings",
              fields: [
                OuterLabelTextField(
                  label: 'Support Phone',
                  controller: controller.appUrlController,
                  prefixIcon: const Icon(Iconsax.call),
                  keyboardType: TextInputType.number,
                  hint: '9876543210',
                ),
                OuterLabelTextField(
                  label: 'Support WhatsApp',
                  controller: controller.playStoreUrlController,
                  prefixIcon: const Icon(PhosphorIconsBold.whatsappLogo),
                  keyboardType: TextInputType.number,
                  hint: '9876543210',
                ),
                OuterLabelTextField(
                  label: 'Support Email',
                  controller: controller.playStoreUrlController,
                  prefixIcon: const Icon(PhosphorIconsBold.paperPlaneRight),
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Support@domain.com',
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
