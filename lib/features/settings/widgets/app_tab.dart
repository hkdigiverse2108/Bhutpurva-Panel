import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdminFormSectionCard(
              title: 'App Details',
              fields: [
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: ColorConst.softGrey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TableActionButton(
                                onTap: () {},
                                label: 'Update Logo',
                                icon: PhosphorIconsRegular.pencil,
                                color: ColorConst.primary,
                              ),
                              const Gap(16),
                              TableActionButton(
                                onTap: () {},
                                label: 'Remove Logo',
                                icon: PhosphorIconsRegular.trash,
                                color: ColorConst.error,
                              ),
                            ],
                          ),
                          const Gap(10),
                          Text(
                            "Images should be at least 400 x 400px as a png or jpeg file.",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: controller.appNameController,
                        decoration: InputDecoration(
                          labelText: 'App Name',
                          hintText: "Enter App Name",
                          prefixIcon: const Icon(
                            PhosphorIconsBold.appWindow,
                            fill: 0.0,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: controller.webSiteUrlController,
                        decoration: InputDecoration(
                          labelText: 'Website Url',
                          hintText: "Enter Website Url",
                          prefixIcon: const Icon(
                            PhosphorIconsBold.globe,
                            fill: 0.0,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone Number is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(16),
            SizedBox(
              width: 550,
              child: AdminFormSectionCard(
                title: "App Links",
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
      ),
    );
  }
}
