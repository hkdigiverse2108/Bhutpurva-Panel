import 'package:bhutpurva_penal/features/alumni/update_alumni/controllers/update_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MajorDetails extends StatelessWidget {
  const MajorDetails({super.key, required this.controller});

  final UpdateAlumniController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminFormSectionCard(
          title: 'Class 10 Details',
          fields: [
            Row(
              children: [
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Class 10 Studied in Gurukul?',
                    prefixIcon: PhosphorIconsBold.student,
                    onChanged: (value) {},
                    items: [
                      AdminDropdownItem(value: 'yes', label: 'Yes'),
                      AdminDropdownItem(value: 'no', label: 'No'),
                    ],
                  ),
                ),
                const Gap(16),
                Expanded(child: Container()),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Branch',
                    onChanged: (value) {},
                    items: [
                      AdminDropdownItem(value: 'yes', label: 'Yes'),
                      AdminDropdownItem(value: 'no', label: 'No'),
                    ],
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Passing Year',
                    onChanged: (value) {},
                    items: [
                      AdminDropdownItem(value: '2000', label: '2000'),
                      AdminDropdownItem(value: '2001', label: '2001'),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Medium',
                    onChanged: (value) {},
                    items: [
                      AdminDropdownItem(value: 'Hindi', label: 'Hindi'),
                      AdminDropdownItem(value: 'English', label: 'English'),
                      AdminDropdownItem(value: 'Gujarati', label: 'Gujarati'),
                    ],
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Hostel',
                    onChanged: (value) {},
                    items: [
                      AdminDropdownItem(value: 'hostel', label: 'Hostel'),
                      AdminDropdownItem(
                        value: 'non-hostel',
                        label: 'Non-Hostel',
                      ),
                    ],
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
                  child: AdminSearchSelectField(
                    label: 'Class 12 Studied in Gurukul?',
                    prefixIcon: PhosphorIconsBold.student,
                    onChanged: (value) {},
                    items: [
                      AdminDropdownItem(value: 'yes', label: 'Yes'),
                      AdminDropdownItem(value: 'no', label: 'No'),
                    ],
                  ),
                ),
                const Gap(16),
                Expanded(child: Container()),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Branch',
                    onChanged: (value) {},
                    items: [
                      AdminDropdownItem(value: 'yes', label: 'Yes'),
                      AdminDropdownItem(value: 'no', label: 'No'),
                    ],
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Passing Year',
                    onChanged: (value) {},
                    items: [
                      AdminDropdownItem(value: '2000', label: '2000'),
                      AdminDropdownItem(value: '2001', label: '2001'),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Medium',
                    onChanged: (value) {},
                    items: [
                      AdminDropdownItem(value: 'Hindi', label: 'Hindi'),
                      AdminDropdownItem(value: 'English', label: 'English'),
                      AdminDropdownItem(value: 'Gujarati', label: 'Gujarati'),
                    ],
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: AdminSearchSelectField(
                    label: 'Hostel',
                    onChanged: (value) {},
                    items: [
                      AdminDropdownItem(value: 'hostel', label: 'Hostel'),
                      AdminDropdownItem(
                        value: 'non-hostel',
                        label: 'Non-Hostel',
                      ),
                    ],
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
