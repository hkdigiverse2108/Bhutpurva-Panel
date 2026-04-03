import 'package:bhutpurva_penal/features/alumni/update_alumni/controllers/update_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MajorDetails extends StatelessWidget {
  const MajorDetails({super.key, required this.controller});

  final UpdateAlumniController controller;

  @override
  Widget build(BuildContext context) {
    final years = List.generate(30, (index) => (2025 - index).toString());
    
    return Column(
      children: [
        AdminFormSectionCard(
          title: 'Class 10 Details',
          fields: [
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => AdminSearchSelectField(
                      label: 'Class 10 Studied in Gurukul?',
                      prefixIcon: PhosphorIconsBold.student,
                      value: controller.isClass10StudiedInGurukul.value ? 'yes' : 'no',
                      onChanged: (value) {
                        if (value != null) {
                          controller.isClass10StudiedInGurukul.value = (value == 'yes');
                        }
                      },
                      items: [
                        AdminDropdownItem(value: 'yes', label: 'Yes'),
                        AdminDropdownItem(value: 'no', label: 'No'),
                      ],
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(child: Container()),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => AdminSearchSelectField(
                      label: 'Branch',
                      value: controller.class10Branch.value,
                      onChanged: (value) {
                        if (value != null) controller.class10Branch.value = value;
                      },
                      items: controller.branches
                          .map(
                            (e) => AdminDropdownItem(
                              value: e.name,
                              label: e.name,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Obx(
                    () => AdminSearchSelectField(
                      label: 'Passing Year',
                      value: controller.class10PassingYear.value,
                      onChanged: (value) {
                        if (value != null) controller.class10PassingYear.value = value;
                      },
                      items: years.map((e) => AdminDropdownItem(value: e, label: e)).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => AdminSearchSelectField(
                      label: 'Medium',
                      value: controller.class10Medium.value,
                      onChanged: (value) {
                        if (value != null) controller.class10Medium.value = value;
                      },
                      items: [
                        AdminDropdownItem(value: 'Hindi', label: 'Hindi'),
                        AdminDropdownItem(value: 'English', label: 'English'),
                        AdminDropdownItem(value: 'Gujarati', label: 'Gujarati'),
                      ],
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Obx(
                    () => AdminSearchSelectField(
                      label: 'Hostel',
                      value: controller.isClass10Hostel.value ? 'hostel' : 'non-hostel',
                      onChanged: (value) {
                        if (value != null) {
                          controller.isClass10Hostel.value = (value == 'hostel');
                        }
                      },
                      items: [
                        AdminDropdownItem(value: 'hostel', label: 'Hostel'),
                        AdminDropdownItem(
                          value: 'non-hostel',
                          label: 'Non-Hostel',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(16),
        AdminFormSectionCard(
          title: 'Class 12 Details',
          fields: [
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => AdminSearchSelectField(
                      label: 'Class 12 Studied in Gurukul?',
                      prefixIcon: PhosphorIconsBold.student,
                      value: controller.isClass12StudiedInGurukul.value ? 'yes' : 'no',
                      onChanged: (value) {
                        if (value != null) {
                          controller.isClass12StudiedInGurukul.value = (value == 'yes');
                        }
                      },
                      items: [
                        AdminDropdownItem(value: 'yes', label: 'Yes'),
                        AdminDropdownItem(value: 'no', label: 'No'),
                      ],
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(child: Container()),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => AdminSearchSelectField(
                      label: 'Branch',
                      value: controller.class12Branch.value,
                      onChanged: (value) {
                        if (value != null) controller.class12Branch.value = value;
                      },
                      items: controller.branches
                          .map(
                            (e) => AdminDropdownItem(
                              value: e.name,
                              label: e.name,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Obx(
                    () => AdminSearchSelectField(
                      label: 'Passing Year',
                      value: controller.class12PassingYear.value,
                      onChanged: (value) {
                        if (value != null) controller.class12PassingYear.value = value;
                      },
                      items: years.map((e) => AdminDropdownItem(value: e, label: e)).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => AdminSearchSelectField(
                      label: 'Medium',
                      value: controller.class12Medium.value,
                      onChanged: (value) {
                        if (value != null) controller.class12Medium.value = value;
                      },
                      items: [
                        AdminDropdownItem(value: 'Hindi', label: 'Hindi'),
                        AdminDropdownItem(value: 'English', label: 'English'),
                        AdminDropdownItem(value: 'Gujarati', label: 'Gujarati'),
                      ],
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Obx(
                    () => AdminSearchSelectField(
                      label: 'Hostel',
                      value: controller.isClass12Hostel.value ? 'hostel' : 'non-hostel',
                      onChanged: (value) {
                        if (value != null) {
                          controller.isClass12Hostel.value = (value == 'hostel');
                        }
                      },
                      items: [
                        AdminDropdownItem(value: 'hostel', label: 'Hostel'),
                        AdminDropdownItem(
                          value: 'non-hostel',
                          label: 'Non-Hostel',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
