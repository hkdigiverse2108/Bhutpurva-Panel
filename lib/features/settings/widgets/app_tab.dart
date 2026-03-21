import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/device/device_utility.dart';
import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/outer_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppTab extends StatelessWidget {
  const AppTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    final bool isMobile = DeviceUtility.isMobileScreen(context);

    return Form(
      key: controller.appFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminFormSectionCard(
            title: 'App Details',
            fields: [
              if (isMobile)
                Column(
                  children: [
                    _buildLogo(controller),
                    const Gap(16),
                    _buildLogoActions(controller),
                  ],
                )
              else
                Row(
                  children: [
                    _buildLogo(controller),
                    const Gap(16),
                    Expanded(child: _buildLogoActions(controller)),
                  ],
                ),
              const Gap(16),
              if (isSmallScreen(context)) ...[
                _buildAppNameField(controller),
                const Gap(16),
                _buildWebsiteUrlField(controller),
              ] else
                Row(
                  children: [
                    Expanded(child: _buildAppNameField(controller)),
                    const Gap(16),
                    Expanded(child: _buildWebsiteUrlField(controller)),
                  ],
                ),
              const Gap(16),
              _buildAddressField(controller),
            ],
          ),
          const Gap(16),
          SizedBox(
            width: isMobile ? double.infinity : 550,
            child: AdminFormSectionCard(
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
                const Gap(16),
                SizedBox(
                  width: isMobile ? double.infinity : 150,
                  child: ElevatedButton(
                    onPressed: controller.updateApp,
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 1000;

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
                PhosphorIconsBold.appWindow,
                size: 40,
                color: ColorConst.grey,
              )
            : null,
      ),
    );
  }

  Widget _buildLogoActions(SettingsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 10,
          children: [
            TableActionButton(
              onTap: () {},
              label: 'Update Logo',
              icon: PhosphorIconsRegular.pencil,
              color: ColorConst.primary,
            ),
            TableActionButton(
              onTap: () {},
              label: 'Remove Logo',
              icon: PhosphorIconsRegular.trash,
              color: ColorConst.error,
            ),
          ],
        ),
        const Gap(10),
        const Text(
          "Images should be at least 400 x 400px as a png or jpeg file.",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAppNameField(SettingsController controller) {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: controller.appNameController,
      decoration: const InputDecoration(
        labelText: 'App Name',
        hintText: "Enter App Name",
        prefixIcon: Icon(PhosphorIconsBold.appWindow, fill: 0.0),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Name is required';
        }
        return null;
      },
    );
  }

  Widget _buildWebsiteUrlField(SettingsController controller) {
    return TextFormField(
      keyboardType: TextInputType.url,
      controller: controller.webSiteUrlController,
      decoration: const InputDecoration(
        labelText: 'Website Url',
        hintText: "Enter Website Url",
        prefixIcon: Icon(PhosphorIconsBold.globe, fill: 0.0),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Website URL is required';
        }
        return null;
      },
    );
  }

  Widget _buildAddressField(SettingsController controller) {
    return TextFormField(
      controller: controller.organizationAddressController,
      decoration: const InputDecoration(
        labelText: 'Organization Address',
        hintText: "Enter Organization Address",
        prefixIcon: Icon(PhosphorIconsBold.mapPin, fill: 0.0),
      ),
    );
  }
}
