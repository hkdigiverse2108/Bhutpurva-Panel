import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/alumni/update_alumni/controllers/update_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PrimaryDetails extends StatelessWidget {
  const PrimaryDetails({super.key, required this.controller});

  final UpdateAlumniController controller;

  @override
  Widget build(BuildContext context) {
    return AdminFormSectionCard(
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
                  prefixIcon: const Icon(PhosphorIconsBold.user, fill: 0.0),
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
                controller: controller.fatherNameController,
                decoration: InputDecoration(
                  labelText: 'Father Name',
                  hintText: "Enter Father Name",
                  prefixIcon: const Icon(PhosphorIconsBold.user, fill: 0.0),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Father name is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: controller.surnameController,
                decoration: InputDecoration(
                  labelText: 'Surname',
                  hintText: "Enter Surname",
                  prefixIcon: const Icon(
                    PhosphorIconsBold.identificationCard,
                    fill: 0.0,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Surname is required';
                  }
                  return null;
                },
              ),
            ),
            const Gap(16),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: controller.birthDateController,
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  hintText: "Select Date",
                  prefixIcon: const Icon(PhosphorIconsBold.calendar, fill: 0.0),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await controller.selectDate();
                  if (date != null) {
                    controller.birthDateController.text = date;
                  }
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Father name is required';
                  }
                  return null;
                },
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
                  labelText: 'Phone Number',
                  hintText: "Enter Phone Number",
                  prefixIcon: const Icon(PhosphorIconsBold.phone, fill: 0.0),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
              ),
            ),
            const Gap(16),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: controller.fatherNameController,
                decoration: InputDecoration(
                  labelText: 'WhatsApp Number',
                  hintText: "Enter WhatsApp Number",
                  prefixIcon: const Icon(
                    PhosphorIconsBold.whatsappLogo,
                    fill: 0.0,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'WhatsApp Number is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: AdminSearchSelectField(
                label: 'Gender',
                prefixIcon: PhosphorIconsBold.genderIntersex,
                onChanged: (value) {},
                items: [
                  AdminDropdownItem(value: 'Male', label: 'Male'),
                  AdminDropdownItem(value: 'Female', label: 'Female'),
                  AdminDropdownItem(value: 'Other', label: 'Other'),
                ],
              ),
            ),
            const Gap(16),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: controller.fatherNameController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: "Enter WhatsApp Number",
                  prefixIcon: const Icon(
                    PhosphorIconsBold.paperPlaneRight,
                    fill: 0.0,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'WhatsApp Number is required';
                  }
                  return null;
                },
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
                  labelText: 'HR Number',
                  hintText: "Enter HR Number",
                  prefixIcon: const Icon(
                    PhosphorIconsBold.identificationBadge,
                    fill: 0.0,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'HR Number is required';
                  }
                  return null;
                },
              ),
            ),
            const Gap(16),
            Expanded(
              child: AdminSearchSelectField(
                label: 'Current City',
                prefixIcon: PhosphorIconsBold.city,
                onChanged: (value) {},
                items: [
                  AdminDropdownItem(value: 'surat', label: 'Surat'),
                  AdminDropdownItem(value: 'other', label: 'Other'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
