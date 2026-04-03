import 'dart:developer';

import 'package:bhutpurva_penal/features/alumni/update_alumni/controllers/update_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/models/address/location_model.dart';
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
    return Column(
      children: [
        // Current Address
        _buildAddressSection(
          title: 'Current Address',
          rxAddress: controller.currentAddress,
          controller: controller,
        ),

        const Gap(16),
        // Village Address
        _buildAddressSection(
          title: 'Village Address',
          rxAddress: controller.villageAddress,
          controller: controller,
        ),

        const Gap(16),
        // Other Addresses
        Obx(() {
          if (controller.otherAddressList.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            children: List.generate(controller.otherAddressList.length, (i) {
              final other = controller.otherAddressList[i];
              final rxEntry = other['address'] as Rx<AddressEntry>;
              final rxType = other['selectedType'] as Rx<String>;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildOtherAddressSection(
                  index: i,
                  rxAddress: rxEntry,
                  rxType: rxType,
                  controller: controller,
                ),
              );
            }),
          );
        }),
        // Add Other Address Button
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => controller.addOtherAddress(),
            icon: const Icon(PhosphorIconsRegular.plus),
            label: const Text('Add Other Address'),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection({
    required String title,
    required Rx<AddressEntry> rxAddress,
    required UpdateAlumniController controller,
  }) {
    final entry = rxAddress.value;
    return AdminFormSectionCard(
      title: title,
      fields: [
        OuterLabelTextField(
          label: 'Full Address',
          hint: 'Enter Address',
          maxLines: 3,
          controller: entry.fullAddressController,
          onChanged: (value) => controller.onAddressChanged(rxAddress, value),
        ),
        // Country Dropdown
        Obx(() {
          final entry = rxAddress.value;
          return AdminSearchSelectField(
            label: 'Country',
            isLoading: entry.loadingCountries,
            value: entry.selectedCountryId,
            items: entry.countries
                .map((e) => AdminDropdownItem(value: e.id, label: e.name))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              final country = entry.countries.firstWhere((c) => c.id == value);
              controller.onCountryChanged(rxAddress, country.id, country.name);
            },
          );
        }),

        // State Dropdown
        Obx(() {
          final entry = rxAddress.value;
          return AdminSearchSelectField(
            label: 'State',
            enabled: entry.selectedCountryId != null,
            hint: entry.selectedCountryId == null
                ? 'Select Country first'
                : 'Select State',
            isLoading: entry.loadingStates,
            value: entry.selectedStateId,
            items: entry.states
                .map((e) => AdminDropdownItem(value: e.id, label: e.name))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              final state = entry.states.firstWhere((s) => s.id == value);
              controller.onStateChanged(rxAddress, state.id, state.name);
            },
          );
        }),

        // District Dropdown
        Obx(() {
          final entry = rxAddress.value;
          return AdminSearchSelectField(
            label: 'District',
            enabled: entry.selectedStateId != null,
            hint: entry.selectedStateId == null
                ? 'Select State first'
                : 'Select District',
            isLoading: entry.loadingDistricts,
            value: entry.selectedDistrictId,
            items: entry.districts
                .map((e) => AdminDropdownItem(value: e.id, label: e.name))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              final district = entry.districts.firstWhere((d) => d.id == value);
              controller.onDistrictChanged(
                rxAddress,
                district.id,
                district.name,
              );
            },
          );
        }),
        // City Dropdown
        Obx(() {
          final entry = rxAddress.value;
          return AdminSearchSelectField(
            label: 'City',
            enabled: entry.selectedDistrictId != null,
            hint: entry.selectedDistrictId == null
                ? 'Select District first'
                : 'Select City',
            isLoading: entry.loadingCities,
            value: entry.selectedCityId,
            items: entry.cities
                .map((e) => AdminDropdownItem(value: e.id, label: e.name))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              final city = entry.cities.firstWhere((c) => c.id == value);
              controller.onCityChanged(rxAddress, city.id, city.name);
            },
          );
        }),

        TextFormField(
          controller: entry.pincodeController,
          decoration: InputDecoration(
            labelText: 'Pincode',
            hintText: 'Enter Pincode',
            prefixIcon: const Icon(
              PhosphorIconsRegular.gps,
              color: Colors.grey,
            ),
          ),
          onChanged: (value) => controller.onPincodeChanged(rxAddress, value),
        ),
      ],
    );
  }

  Widget _buildOtherAddressSection({
    required int index,
    required Rx<AddressEntry> rxAddress,
    required Rx<String> rxType,
    required UpdateAlumniController controller,
  }) {
    final entry = rxAddress.value;
    return AdminFormSectionCard(
      title: 'Other Address ${index + 1}',
      fields: [
        Row(
          children: [
            Expanded(
              child: Obx(
                () => AdminSearchSelectField(
                  label: 'Address Type',
                  value: rxType.value,
                  items: controller.addressType
                      .map((e) => AdminDropdownItem(value: e, label: e))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) rxType.value = value;
                  },
                ),
              ),
            ),
            const Gap(16),
            IconButton(
              onPressed: () => controller.removeOtherAddress(index),
              icon: const Icon(
                PhosphorIconsRegular.trash,
                color: Colors.redAccent,
              ),
              tooltip: 'Remove Address',
            ),
          ],
        ),
        OuterLabelTextField(
          label: 'Full Address',
          hint: 'Enter Address',
          maxLines: 3,
          controller: entry.fullAddressController,
          onChanged: (value) => controller.onAddressChanged(rxAddress, value),
        ),

        Obx(() {
          final entry = rxAddress.value;
          return AdminSearchSelectField(
            label: 'Country',
            isLoading: entry.loadingCountries,
            value: entry.selectedCountryId,
            items: entry.countries
                .map((e) => AdminDropdownItem(value: e.id, label: e.name))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              final country = entry.countries.firstWhere((c) => c.id == value);
              controller.onCountryChanged(rxAddress, country.id, country.name);
            },
          );
        }),

        Obx(() {
          final entry = rxAddress.value;
          return AdminSearchSelectField(
            label: 'State',
            enabled: entry.selectedCountryId != null,
            hint: entry.selectedCountryId == null
                ? 'Select Country first'
                : 'Select State',
            isLoading: entry.loadingStates,
            value: entry.selectedStateId,
            items: entry.states
                .map((e) => AdminDropdownItem(value: e.id, label: e.name))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              final state = entry.states.firstWhere((s) => s.id == value);
              controller.onStateChanged(rxAddress, state.id, state.name);
            },
          );
        }),

        Obx(() {
          final entry = rxAddress.value;
          return AdminSearchSelectField(
            label: 'District',
            enabled: entry.selectedStateId != null,
            hint: entry.selectedStateId == null
                ? 'Select State first'
                : 'Select District',
            isLoading: entry.loadingDistricts,
            value: entry.selectedDistrictId,
            items: entry.districts
                .map((e) => AdminDropdownItem(value: e.id, label: e.name))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              final district = entry.districts.firstWhere((d) => d.id == value);
              controller.onDistrictChanged(
                rxAddress,
                district.id,
                district.name,
              );
            },
          );
        }),

        Obx(() {
          final entry = rxAddress.value;
          return AdminSearchSelectField(
            label: 'City',
            enabled: entry.selectedDistrictId != null,
            hint: entry.selectedDistrictId == null
                ? 'Select District first'
                : 'Select City',
            isLoading: entry.loadingCities,
            value: entry.selectedCityId,
            items: entry.cities
                .map((e) => AdminDropdownItem(value: e.id, label: e.name))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              final city = entry.cities.firstWhere((c) => c.id == value);
              controller.onCityChanged(rxAddress, city.id, city.name);
            },
          );
        }),
        TextFormField(
          controller: entry.pincodeController,
          decoration: InputDecoration(
            labelText: 'Pincode',
            hintText: 'Enter Pincode',
            prefixIcon: const Icon(
              PhosphorIconsRegular.gps,
              color: Colors.grey,
            ),
          ),
          onChanged: (value) => controller.onPincodeChanged(rxAddress, value),
        ),
      ],
    );
  }
}
