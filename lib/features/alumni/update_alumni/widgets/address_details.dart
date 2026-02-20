import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/features/alumni/update_alumni/controllers/update_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/buttons/table_action_button.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/outer_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UpdateAlumniController.instance;
    return AdminFormSectionCard(
      title: 'Address Details',
      trailing: TableActionButton(
        onTap: () {},
        label: 'add New',
        icon: Icons.add,
        color: ColorConst.primary,
      ),
      fields: [
        addressFields(),
        Gap(1),
        addressFields(label: 'Village Address'),
      ],
    );
  }

  Widget addressFields({String label = 'Current Address'}) {
    return Column(
      children: [
        OuterLabelTextField(label: label, hint: 'Enter Address', maxLines: 3),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'City',
                  hintText: 'Enter City',
                  prefixIcon: const Icon(
                    PhosphorIconsRegular.city,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const Gap(16),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'District',
                  hintText: 'Enter District',
                  prefixIcon: const Icon(
                    PhosphorIconsRegular.city,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'State',
                  hintText: 'Enter State',
                  prefixIcon: const Icon(
                    PhosphorIconsRegular.city,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const Gap(16),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Pincode',
                  hintText: 'Enter Pincode',
                  prefixIcon: const Icon(
                    PhosphorIconsRegular.gps,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(12),
        AdminSearchSelectField(
          label: 'Country',
          items: [],
          onChanged: (value) {},
        ),
      ],
    );
  }
}
