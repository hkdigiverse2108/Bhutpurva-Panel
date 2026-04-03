import 'package:get/get.dart';
import '../../core/constants/api_constants.dart';
import '../../core/services/api_service.dart';
import '../../shared/models/address/location_model.dart';
import '../../shared/models/res/res_model.dart';

mixin LocationDropdownMixin {
  Future<AddressEntry> _internalLoadCountries(AddressEntry entry) async {
    entry = entry.copyWith(loadingCountries: true);
    try {
      final ResModel res = await ApiService().get(
        ApiConstants.location(typeFilter: 'country'),
      );
      if (res.status == 200 && res.data != null) {
        final countries = (res.data as List)
            .map((e) => LocationModel.fromJson(e))
            .toList();
        return entry.copyWith(countries: countries, loadingCountries: false);
      }
    } catch (_) {}
    return entry.copyWith(loadingCountries: false);
  }

  Future<void> loadCountriesFor(Rx<AddressEntry> rxAddress) async {
    rxAddress.value = await _internalLoadCountries(rxAddress.value);
  }

  Future<AddressEntry> _internalCountryChanged(
    AddressEntry entry,
    String countryId,
    String countryName,
  ) async {
    var nextState = entry.resetStateAndBelow().copyWith(
      selectedCountryId: countryId,
      selectedCountryName: countryName,
      loadingStates: true,
    );

    try {
      final ResModel res = await ApiService().get(
        ApiConstants.location(typeFilter: 'state', parentId: countryId),
      );
      if (res.status >= 200 && res.status < 300 && res.data != null) {
        final states = (res.data as List)
            .map((e) => LocationModel.fromJson(e))
            .toList();
        return nextState.copyWith(states: states, loadingStates: false);
      }
    } catch (_) {}
    return nextState.copyWith(loadingStates: false);
  }

  Future<void> onCountryChanged(
    Rx<AddressEntry> rxAddress,
    String countryId,
    String countryName,
  ) async {
    rxAddress.value = await _internalCountryChanged(
      rxAddress.value,
      countryId,
      countryName,
    );
  }

  Future<AddressEntry> _internalStateChanged(
    AddressEntry entry,
    String stateId,
    String stateName,
  ) async {
    var nextState = entry.resetDistrictAndBelow().copyWith(
      selectedStateId: stateId,
      selectedStateName: stateName,
      loadingDistricts: true,
    );

    try {
      final ResModel res = await ApiService().get(
        ApiConstants.location(typeFilter: 'district', parentId: stateId),
      );
      if (res.status >= 200 && res.status < 300 && res.data != null) {
        final districts = (res.data as List)
            .map((e) => LocationModel.fromJson(e))
            .toList();
        return nextState.copyWith(
          districts: districts,
          loadingDistricts: false,
        );
      }
    } catch (_) {}
    return nextState.copyWith(loadingDistricts: false);
  }

  Future<void> onStateChanged(
    Rx<AddressEntry> rxAddress,
    String stateId,
    String stateName,
  ) async {
    rxAddress.value = await _internalStateChanged(
      rxAddress.value,
      stateId,
      stateName,
    );
  }

  Future<AddressEntry> _internalDistrictChanged(
    AddressEntry entry,
    String districtId,
    String districtName,
  ) async {
    var nextState = entry.resetCity().copyWith(
      selectedDistrictId: districtId,
      selectedDistrictName: districtName,
      loadingCities: true,
    );

    try {
      final ResModel res = await ApiService().get(
        ApiConstants.location(typeFilter: 'city', parentId: districtId),
      );
      if (res.status >= 200 && res.status < 300 && res.data != null) {
        final cities = (res.data as List)
            .map((e) => LocationModel.fromJson(e))
            .toList();
        return nextState.copyWith(cities: cities, loadingCities: false);
      }
    } catch (_) {}
    return nextState.copyWith(loadingCities: false);
  }

  Future<void> onDistrictChanged(
    Rx<AddressEntry> rxAddress,
    String districtId,
    String districtName,
  ) async {
    rxAddress.value = await _internalDistrictChanged(
      rxAddress.value,
      districtId,
      districtName,
    );
  }

  void onCityChanged(
    Rx<AddressEntry> rxAddress,
    String cityId,
    String cityName,
  ) {
    rxAddress.value = rxAddress.value.copyWith(
      selectedCityId: cityId,
      selectedCityName: cityName,
    );
  }

  void onAddressChanged(Rx<AddressEntry> rxAddress, String fullAddress) {
    rxAddress.value = rxAddress.value.copyWith(fullAddress: fullAddress);
  }

  void onPincodeChanged(Rx<AddressEntry> rxAddress, String pincode) {
    rxAddress.value = rxAddress.value.copyWith(pincode: pincode);
  }

  Future<void> prefillAddressEntry(
    Rx<AddressEntry> rxAddress, {
    String? savedCountry,
    String? savedState,
    String? savedDistrict,
    String? savedCity,
    String? fullAddress,
    String? pincode,
  }) async {
    // Initial controller update (Synchronous part)
    rxAddress.value.fullAddressController.text = fullAddress ?? '';
    rxAddress.value.pincodeController.text = pincode ?? '';

    var entry = rxAddress.value.copyWith(
      fullAddress: fullAddress ?? '',
      pincode: pincode ?? '',
    );

    // 1. Fetch Countries
    entry = await _internalLoadCountries(entry);
    rxAddress.value = entry; // Update UI once after country load
    if (savedCountry == null || savedCountry.isEmpty) return;

    final countryMatch = entry.countries.firstWhereOrNull(
      (c) =>
          c.id == savedCountry ||
          c.name.toLowerCase().trim() == savedCountry.toLowerCase().trim(),
    );
    if (countryMatch == null) {
      Get.log("Location prefill error: Country '$savedCountry' not found.");
      return;
    }

    // 2. Fetch States
    entry = await _internalCountryChanged(
      entry,
      countryMatch.id,
      countryMatch.name,
    );
    rxAddress.value = entry; // Update UI after states load
    if (savedState == null || savedState.isEmpty) return;

    final stateMatch = entry.states.firstWhereOrNull(
      (s) =>
          s.id == savedState ||
          s.name.toLowerCase().trim() == savedState.toLowerCase().trim(),
    );
    if (stateMatch == null) {
      Get.log("Location prefill error: State '$savedState' not found.");
      return;
    }

    // 3. Fetch Districts
    entry = await _internalStateChanged(entry, stateMatch.id, stateMatch.name);
    rxAddress.value = entry; // Update UI after districts load
    if (savedDistrict == null || savedDistrict.isEmpty) return;

    final districtMatch = entry.districts.firstWhereOrNull(
      (d) =>
          d.id == savedDistrict ||
          d.name.toLowerCase().trim() == savedDistrict.toLowerCase().trim(),
    );
    if (districtMatch == null) {
      Get.log("Location prefill error: District '$savedDistrict' not found.");
      return;
    }

    // 4. Fetch Cities
    entry = await _internalDistrictChanged(
      entry,
      districtMatch.id,
      districtMatch.name,
    );
    rxAddress.value = entry; // Update UI after cities load
    if (savedCity == null || savedCity.isEmpty) return;

    final cityMatch = entry.cities.firstWhereOrNull(
      (c) =>
          c.id == savedCity ||
          c.name.toLowerCase().trim() == savedCity.toLowerCase().trim(),
    );
    if (cityMatch != null) {
      rxAddress.value = entry.copyWith(
        selectedCityId: cityMatch.id,
        selectedCityName: cityMatch.name,
      );
    } else {
      Get.log("Location prefill error: City '$savedCity' not found.");
    }
  }
}
