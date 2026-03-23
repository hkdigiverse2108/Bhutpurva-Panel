import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/device/device_utility.dart';
import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    final isMobile = DeviceUtility.isMobileScreen(context);

    return Form(
      key: controller.accountFormKey,
      child: Column(
        children: [
          AdminFormSectionCard(
            title: 'Primary Details',
            fields: [
              // Avatar Section
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: ColorConst.softGrey,
                        shape: BoxShape.circle,
                        image: controller.usersProfileImage.value.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(
                                  controller.usersProfileImage.value,
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: controller.usersProfileImage.value.isEmpty
                          ? const Icon(
                              PhosphorIconsBold.user,
                              size: 40,
                              color: ColorConst.grey,
                            )
                          : null,
                    ),
                  ),
                  const Gap(16),
                  Column(
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      Flex(
                        direction: isMobile ? Axis.vertical : Axis.horizontal,
                        children: [
                          TableActionButton(
                            onTap: () =>
                                controller.usersProfileImage.value = '',
                            label: 'Update Image',
                            icon: PhosphorIconsRegular.pencil,
                            color: ColorConst.primary,
                          ),
                          Gap(isMobile ? 10 : 16),
                          TableActionButton(
                            onTap: () {
                              controller.usersProfileImage.value = '';
                            },
                            label: 'Remove',
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
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.start,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // const Gap(8),

              // Name & Phone
              _buildResponsiveRow(isMobile, [
                _buildTextField(
                  label: 'Name',
                  hint: 'Enter Name',
                  controller: controller.nameController,
                  icon: PhosphorIconsBold.user,
                ),
                _buildTextField(
                  label: 'Phone Number',
                  hint: 'Enter Phone Number',
                  controller: controller.phoneController,
                  icon: PhosphorIconsBold.phone,
                  keyboardType: TextInputType.phone,
                ),
              ]),
              // Email & Address
              _buildResponsiveRow(isMobile, [
                _buildTextField(
                  label: 'Email',
                  hint: 'Enter Email',
                  controller: controller.emailController,
                  icon: PhosphorIconsBold.envelope,
                  keyboardType: TextInputType.emailAddress,
                ),
                _buildTextField(
                  label: 'City',
                  hint: 'Enter City',
                  controller: controller.cityController,
                  icon: PhosphorIconsBold.mapPin,
                ),
              ]),

              // const Gap(16),

              // Update Button
              Align(
                alignment: isMobile ? Alignment.center : Alignment.centerRight,
                child: SizedBox(
                  width: isMobile ? double.infinity : 150,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: controller.updateAccount,
                    child: const Text('Update Profile'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, fill: 0.0),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }
}
