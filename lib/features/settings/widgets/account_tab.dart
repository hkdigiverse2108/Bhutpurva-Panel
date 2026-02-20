import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Form(
      key: controller.accountFormKey,
      child: Column(
        children: [
          AdminFormSectionCard(
            title: 'Primary Details',
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
                              label: 'Update Image',
                              icon: PhosphorIconsRegular.pencil,
                              color: ColorConst.primary,
                            ),
                            const Gap(16),
                            TableActionButton(
                              onTap: () {},
                              label: 'Remove',
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
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: "Enter Name",
                        prefixIcon: const Icon(
                          PhosphorIconsBold.user,
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
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: "Enter Phone Number",
                        prefixIcon: const Icon(
                          PhosphorIconsBold.phone,
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
        ],
      ),
    );
  }
}
