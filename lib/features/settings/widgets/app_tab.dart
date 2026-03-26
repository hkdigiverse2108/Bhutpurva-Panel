import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/device/device_utility.dart';
import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/outer_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/form_button.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppTab extends StatelessWidget {
  const AppTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    final isMobile = DeviceUtility.isMobileScreen(context);

    return Form(
      key: controller.appFormKey,
      child: Column(
        children: [
          AdminFormSectionCard(
            title: 'App Details',
            fields: [
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  _buildLogo(controller),
                  const Gap(16),
                  _buildLogoActions(controller, isMobile),
                ],
              ),

              _buildResponsiveRow(isMobile, [
                OuterLabelTextField(
                  label: 'App Name',
                  hint: 'Enter App Name',
                  controller: controller.appNameController,
                  prefixIcon: const Icon(PhosphorIconsBold.appWindow),
                ),
                OuterLabelTextField(
                  label: 'Website Url',
                  hint: 'Enter Website Url',
                  controller: controller.webSiteUrlController,
                  prefixIcon: const Icon(PhosphorIconsBold.globe),
                ),
              ]),

              OuterLabelTextField(
                label: 'Organization Address',
                hint: 'Enter Organization Address',
                controller: controller.organizationAddressController,
                prefixIcon: const Icon(PhosphorIconsBold.mapPin),
              ),
            ],
          ),

          const Gap(16),

          AdminFormSectionCard(
            title: "Platform Details",
            fields: [
              OuterLabelTextField(
                label: 'App Url',
                controller: controller.appUrlController,
                prefixIcon: const Icon(PhosphorIconsBold.link),
                hint: 'https://example.com',
              ),
              OuterLabelTextField(
                label: 'PlayStore Url',
                controller: controller.playStoreUrlController,
                prefixIcon: const Icon(PhosphorIconsBold.googlePlayLogo),
                hint: 'https://play.google.com/store/...',
              ),
              OuterLabelTextField(
                label: 'AppStore Url',
                controller: controller.appStoreUrlController,
                prefixIcon: const Icon(PhosphorIconsBold.appStoreLogo),
                hint: 'https://apps.apple.com/app/...',
              ),

              /// 🔹 Button (aligned like AccountTab)
              Align(
                alignment: isMobile ? Alignment.center : Alignment.centerRight,
                child: SizedBox(
                  width: isMobile ? double.infinity : 150,
                  child: AdminFormButton(
                    onPressed: controller.updateApp,
                    label: 'Update',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(SettingsController controller) {
    return Obx(
      () => Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: ColorConst.softGrey,
          shape: BoxShape.circle,
          image: controller.appLogo.value.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(controller.appLogo.value),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: controller.appLogo.value.isEmpty
            ? const Icon(
                PhosphorIconsBold.user,
                size: 40,
                color: ColorConst.grey,
              )
            : null,
      ),
    );
  }

  Widget _buildLogoActions(SettingsController controller, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          children: [
            TableActionButton(
              onTap: () {},
              label: 'Update Logo',
              icon: PhosphorIconsRegular.pencil,
              color: ColorConst.primary,
            ),
            Gap(isMobile ? 10 : 16),
            TableActionButton(
              onTap: () {},
              label: 'Remove Logo',
              icon: PhosphorIconsRegular.trash,
              color: ColorConst.error,
            ),
          ],
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Images should be at least 400 x 400px as a png or jpeg file.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  /// 🔹 Same helper as AccountTab
  Widget _buildResponsiveRow(bool isMobile, List<Widget> children) {
    if (isMobile) {
      return Column(
        children: children.expand((widget) => [widget, const Gap(16)]).toList()
          ..removeLast(),
      );
    }
    return Row(
      children:
          children
              .expand((widget) => [Expanded(child: widget), const Gap(16)])
              .toList()
            ..removeLast(),
    );
  }
}
