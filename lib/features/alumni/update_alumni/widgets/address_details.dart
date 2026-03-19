import 'package:bhutpurva_penal/features/alumni/update_alumni/controllers/update_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/layouts/templates/admin_form_section_card.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/admin_drop_down_field.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/outer_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UpdateAlumniController.instance;
    return AdminFormSectionCard(
      title: 'Address Details',
      fields: [
        addressFields(
          label: 'Current Address',
          addressController: controller.currentAddressController,
          cityController: controller.currentCityController,
          districtController: controller.currentDistrictController,
          stateController: controller.currentStateController,
          pincodeController: controller.currentPincodeController,
          country: controller.currentCountry,
        ),
        const Gap(24),
        addressFields(
          label: 'Village Address',
          addressController: controller.villageAddressController,
          cityController: controller.villageCityController,
          districtController: controller.villageDistrictController,
          stateController: controller.villageStateController,
          pincodeController: controller.villagePincodeController,
          country: controller.villageCountry,
        ),
      ],
    );
  }

  Widget addressFields({
    required String label,
    required TextEditingController addressController,
    required TextEditingController cityController,
    required TextEditingController districtController,
    required TextEditingController stateController,
    required TextEditingController pincodeController,
    required RxString country,
  }) {
    return Column(
      children: [
        OuterLabelTextField(
          label: label,
          hint: 'Enter Address',
          maxLines: 3,
          controller: addressController,
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: cityController,
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
                controller: districtController,
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
                controller: stateController,
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
                controller: pincodeController,
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
        Obx(
          () => AdminSearchSelectField(
            label: 'Country',
            value: country.value,
            items: [
              AdminDropdownItem(value: 'India', label: 'India'),
              AdminDropdownItem(value: 'Other', label: 'Other'),
            ],
            onChanged: (value) {
              if (value != null) country.value = value;
            },
          ),
        ),
      ],
    );
  }
}
