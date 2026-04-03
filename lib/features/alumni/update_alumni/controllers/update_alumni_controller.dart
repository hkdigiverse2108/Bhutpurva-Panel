import 'dart:developer';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/mixins/location_dropdown_mixin.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/alumni/all_alumni/controllers/all_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/models/address/location_model.dart';
import 'package:bhutpurva_penal/shared/models/branch_model/branch_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateAlumniController extends BaseController with LocationDropdownMixin {
  static UpdateAlumniController get instance => Get.find();

  final apiService = ApiService();

  final RxBool isUpdateLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  late String id;
  UserModel? _currentUser;

  var selectedTab = 0.obs;

  // Primary Details
  final nameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final surnameController = TextEditingController();
  final birthDateController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final whatsappNumberController = TextEditingController();
  final hrNumberController = TextEditingController();
  final occupationController = TextEditingController();
  final currentCityController = TextEditingController();

  String class10Id = "";
  String class12Id = "";

  final gender = 'male'.obs;
  final role = 'user'.obs;
  final currentCity = 'surat'.obs;

  // Class 10 Details
  final isClass10StudiedInGurukul = false.obs;
  final class10Branch = 'Science'.obs;
  final class10PassingYear = '2024'.obs;
  final class10Medium = 'English'.obs;
  final isClass10Hostel = false.obs;

  // Class 12 Details
  final isClass12StudiedInGurukul = false.obs;
  final class12Branch = 'Science'.obs;
  final class12PassingYear = '2024'.obs;
  final class12Medium = 'English'.obs;
  final isClass12Hostel = false.obs;

  // Address Details (aligned with mobile app pattern)
  final currentAddress = AddressEntry().obs;
  final villageAddress = AddressEntry().obs;
  final RxList<Map<String, dynamic>> otherAddressList =
      <Map<String, dynamic>>[].obs;

  final List<String> addressType = ['factory', 'shop', 'office', 'business'];

  // Secondary Details
  final isStudent = false.obs;
  final runsBusiness = false.obs;
  final isEmployee = false.obs;
  final isSelfEmployed = false.obs;
  final isRetired = false.obs;

  final professions = <String>[].obs;
  final educations = <String>[].obs;
  final maritalStatus = 'Single'.obs;
  final bloodGroup = 'A+'.obs;

  // Dynamic branches from API
  final branches = <BranchDropdownModel>[].obs;

  List educationsList = [
    'Bachelor of Science in Computer Science',
    'Bachelor of Arts in English Literature',
    'Master of Business Administration',
    'Master of Science in Artificial Intelligence',
  ].obs;

  List professionsList = [
    'Developer',
    'Designer',
    'Manager',
    'CEO',
    'Artist',
    'Engineer',
    'Doctor',
    'Singer',
    'Actor',
  ];

  List meritStatusList = ['Single', 'Married', 'Widowed', 'Divorced'].obs;

  List bloodGroupsList = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].obs;

  Future<String?> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      return DateFormat('yyyy - MM - dd').format(picked);
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    id = Get.arguments ?? "";
    super.onInit();
  }

  @override
  void onReady() {
    fetchAlumniDetails();
    fetchBranches();
    super.onReady();
  }

  // Fetch branches from API (aligned with mobile app)
  void fetchBranches() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(
          ApiConstants.dropdownBranch(),
        );
        if (res.status == 200 && res.data != null) {
          branches.assignAll(
            (res.data as List)
                .map((e) => BranchDropdownModel.fromJson(e))
                .toList(),
          );
        }
      },
      errorMessage: "Failed to fetch branches",
      showSnackbarOnError: false,
    );
  }

  // Fetch alumni details and populate fields
  void fetchAlumniDetails() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(ApiConstants.userDetails(id));
        if (res.status == 200) {
          final user = UserModel.fromJson(res.data);
          _currentUser = user;
          _populateFields(user);
        }
      },
      errorMessage: "Failed to fetch alumni",
    );
  }

  void _populateFields(UserModel user) {
    // 1. Primary Details
    nameController.text = user.name;
    fatherNameController.text = user.fatherName;
    surnameController.text = user.surname;
    phoneController.text = user.phoneNumber;
    emailController.text = user.email;
    whatsappNumberController.text = user.whatsappNumber;
    hrNumberController.text = user.hrNo;
    gender.value = user.gender;
    role.value = user.role;
    currentCity.value = user.currentCity;
    currentCityController.text = user.currentCity;
    occupationController.text = user.occupation;

    // Birth Date
    if (user.birthDate != null) {
      try {
        final date = DateTime.parse(user.birthDate!);
        birthDateController.text = DateFormat('yyyy - MM - dd').format(date);
      } catch (e) {
        birthDateController.text = user.birthDate!.split("T").first;
        if (ApiConstants.showLogs) log("Error parsing birthDate: $e");
      }
    }

    // 2. Major Details — Class 10
    class10Id = user.class10.id;
    isClass10StudiedInGurukul.value = user.class10.isStudded;
    class10Branch.value = user.class10.branch ?? '';
    class10PassingYear.value = user.class10.passingYear ?? '2024';
    class10Medium.value = user.class10.medium ?? 'English';
    isClass10Hostel.value = user.class10.hostel;

    // Major Details — Class 12
    class12Id = user.class12.id;
    isClass12StudiedInGurukul.value = user.class12.isStudded;
    class12Branch.value = user.class12.branch ?? '';
    class12PassingYear.value = user.class12.passingYear ?? '2024';
    class12Medium.value = user.class12.medium ?? 'English';
    isClass12Hostel.value = user.class12.hostel;

    // 3. Address Details (aligned with mobile app pattern)
    otherAddressList.clear();

    if (user.addressIds.isNotEmpty) {
      // Find current and village/permanent addresses explicitly to avoid overwriting
      final currentAddr = user.addressIds.firstWhereOrNull(
        (a) => a.type.toLowerCase().contains('current'),
      );
      final villageAddr = user.addressIds.firstWhereOrNull(
        (a) =>
            a.type.toLowerCase().contains('village') ||
            a.type.toLowerCase().contains('permanent'),
      );

      if (currentAddr != null) {
        prefillAddressEntry(
          currentAddress,
          savedCountry: currentAddr.country,
          savedState: currentAddr.state,
          savedDistrict: currentAddr.district,
          savedCity: currentAddr.city,
          fullAddress: currentAddr.address,
          pincode: currentAddr.pincode,
        );
      }

      if (villageAddr != null) {
        prefillAddressEntry(
          villageAddress,
          savedCountry: villageAddr.country,
          savedState: villageAddr.state,
          savedDistrict: villageAddr.district,
          savedCity: villageAddr.city,
          fullAddress: villageAddr.address,
          pincode: villageAddr.pincode,
        );
      }

      // Add others
      for (var address in user.addressIds) {
        final type = address.type.toLowerCase();
        if (!type.contains('current') &&
            !type.contains('village') &&
            !type.contains('permanent')) {
          final newOther = AddressEntry().obs;
          otherAddressList.add({
            'selectedType': address.type.obs,
            'address': newOther,
          });
          prefillAddressEntry(
            newOther,
            savedCountry: address.country,
            savedState: address.state,
            savedDistrict: address.district,
            savedCity: address.city,
            fullAddress: address.address,
            pincode: address.pincode,
          );
        }
      }
    }

    // Load countries for addresses that weren't prefilled (i.e. if they were empty in the backend)
    // We only call these if prefillAddressEntry wasn't already triggered for them
    final hasCurrent = user.addressIds.any(
      (a) => a.type.toLowerCase().contains('current'),
    );
    final hasVillage = user.addressIds.any(
      (a) =>
          a.type.toLowerCase().contains('village') ||
          a.type.toLowerCase().contains('permanent'),
    );

    if (!hasCurrent) {
      loadCountriesFor(currentAddress);
    }
    if (!hasVillage) {
      loadCountriesFor(villageAddress);
    }

    // 4. Secondary Details
    professions.assignAll(user.professions);
    educations.assignAll(user.educations.map((e) => e.toString()).toList());
    maritalStatus.value = user.maritalStatus.isNotEmpty
        ? user.maritalStatus
        : 'Single';
    bloodGroup.value = user.bloodGroup.isNotEmpty ? user.bloodGroup : 'A+';

    // Occupation mapping
    final occ = user.occupation.toLowerCase();
    if (occ.contains("student")) isStudent.value = true;
    if (occ.contains("business")) runsBusiness.value = true;
    if (occ.contains("employee")) isEmployee.value = true;
    if (occ.contains("self")) isSelfEmployed.value = true;
    if (occ.contains("retired")) isRetired.value = true;
  }

  void onTabChanged(int index) {
    selectedTab.value = index;
  }

  // Address management (aligned with mobile app)
  void addOtherAddress() {
    final entry = AddressEntry().obs;
    otherAddressList.add({'selectedType': 'select'.obs, 'address': entry});
    loadCountriesFor(entry);
  }

  void removeOtherAddress(int index) {
    if (index >= 0 && index < otherAddressList.length) {
      otherAddressList.removeAt(index);
    }
  }

  // Collect addresses for API payload (aligned with mobile app)
  List<Map<String, dynamic>> _collectAddresses() {
    final List<Map<String, dynamic>> addressList = [];

    // Current Address
    if (currentAddress.value.selectedCountryName != null) {
      final addrId = _currentUser?.addressIds
          .firstWhereOrNull((a) => a.type.toLowerCase() == 'current')
          ?.id;
      addressList.add(
        _buildAddressMap(currentAddress.value, 'current', addrId),
      );
    }

    // Village Address
    if (villageAddress.value.selectedCountryName != null) {
      final addrId = _currentUser?.addressIds
          .firstWhereOrNull(
            (a) =>
                a.type.toLowerCase() == 'village' ||
                a.type.toLowerCase() == 'permanent',
          )
          ?.id;
      addressList.add(
        _buildAddressMap(villageAddress.value, 'village', addrId),
      );
    }

    // Other Addresses
    for (var i = 0; i < otherAddressList.length; i++) {
      final other = otherAddressList[i];
      final entry = (other['address'] as Rx<AddressEntry>).value;
      final type = (other['selectedType'] as Rx<String>).value;

      if (type != 'select' && entry.selectedCountryName != null) {
        final otherAddresses = _currentUser?.addressIds
            .where(
              (a) => !([
                'current',
                'village',
                'permanent',
              ].contains(a.type.toLowerCase())),
            )
            .toList();

        String? addrId;
        if (otherAddresses != null && i < otherAddresses.length) {
          addrId = otherAddresses[i].id;
        }

        addressList.add(_buildAddressMap(entry, type, addrId));
      }
    }

    return addressList;
  }

  Map<String, dynamic> _buildAddressMap(
    AddressEntry entry,
    String type,
    String? addrId,
  ) {
    return {
      if (addrId != null) 'id': addrId,
      'address': entry.fullAddress,
      'type': type,
      'city': entry.selectedCityName ?? '',
      'district': entry.selectedDistrictName ?? '',
      'state': entry.selectedStateName ?? '',
      'country': entry.selectedCountryName ?? '',
      'pincode': entry.pincode,
    };
  }

  // Reconstruct occupation string from checkboxes
  String _buildOccupation() {
    final parts = <String>[];
    if (isStudent.value) parts.add('Student');
    if (runsBusiness.value) parts.add('Business');
    if (isEmployee.value) parts.add('Employee');
    if (isSelfEmployed.value) parts.add('Self Employed');
    if (isRetired.value) parts.add('Retired');
    if (occupationController.text.trim().isNotEmpty) {
      parts.add(occupationController.text.trim());
    }
    return parts.join(', ');
  }

  void updateAlumniProfile() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    executeApi(
      apiCall: () async {
        // Format birth date
        String? birthDateIso;
        if (birthDateController.text.isNotEmpty) {
          try {
            birthDateIso = DateFormat(
              'yyyy - MM - dd',
            ).parse(birthDateController.text).toIso8601String();
          } catch (e) {
            if (ApiConstants.showLogs) log("Date parse error: $e");
          }
        }

        final body = {
          "userId": id,
          "name": nameController.text,
          "fatherName": fatherNameController.text,
          "surname": surnameController.text,
          "birthDate": birthDateIso,
          "phoneNumber": phoneController.text,
          "whatsappNumber": whatsappNumberController.text,
          "email": emailController.text,
          "gender": gender.value,
          "hrNo": hrNumberController.text,
          "role": role.value,
          "currentCity": currentCityController.text,
          "professions": professions.toList(),
          "education": educations.toList(),
          "maritalStatus": maritalStatus.value,
          "bloodGroup": bloodGroup.value,
          "occupation": _buildOccupation(),
          "class10": {
            "_id": class10Id,
            "isStudded": isClass10StudiedInGurukul.value,
            "branch": class10Branch.value,
            "passingYear": class10PassingYear.value,
            "medium": class10Medium.value,
            "hostel": isClass10Hostel.value,
            "class": "10",
          },
          "class12": {
            "_id": class12Id,
            "isStudded": isClass12StudiedInGurukul.value,
            "branch": class12Branch.value,
            "passingYear": class12PassingYear.value,
            "medium": class12Medium.value,
            "hostel": isClass12Hostel.value,
            "class": "12",
          },
          "addresses": _collectAddresses(),
        };

        final ResModel res = await apiService.put(
          ApiConstants.updateUser,
          body: body,
        );

        if (res.status == 200) {
          AllAlumniController.instance.fetchAlumni();
          Get.back();
          Get.snackbar("Success", "Profile updated successfully");
        }
      },
      loadingState: isUpdateLoading,
      errorMessage: "Failed to update profile",
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    fatherNameController.dispose();
    surnameController.dispose();
    birthDateController.dispose();
    phoneController.dispose();
    emailController.dispose();
    whatsappNumberController.dispose();
    hrNumberController.dispose();
    occupationController.dispose();
    currentCityController.dispose();
    super.onClose();
  }
}
