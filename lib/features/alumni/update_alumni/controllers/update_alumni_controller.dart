import 'dart:developer';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/alumni/all_alumni/controllers/all_alumni_controller.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateAlumniController extends BaseController {
  static UpdateAlumniController get instance => Get.find();
  final apiService = ApiService();

  final RxBool isUpdateLoading = false.obs;

  late String id;

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

  // Address Controllers
  final currentAddressController = TextEditingController();
  final currentCityController = TextEditingController();
  final currentDistrictController = TextEditingController();
  final currentStateController = TextEditingController();
  final currentPincodeController = TextEditingController();
  final currentCountry = 'India'.obs;

  final villageAddressController = TextEditingController();
  final villageCityController = TextEditingController();
  final villageDistrictController = TextEditingController();
  final villageStateController = TextEditingController();
  final villagePincodeController = TextEditingController();
  final villageCountry = 'India'.obs;

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
    fetchAlumniDetails();
    super.onInit();
  }

  // call api
  void fetchAlumniDetails() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(ApiConstants.userDetails(id));
        if (res.status == 200) {
          final user = UserModel.fromJson(res.data);
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
          professions.assignAll(user.professions);
          educations.assignAll(
            user.educations.map((e) => e.toString()).toList(),
          );
          maritalStatus.value = user.maritalStatus;
          bloodGroup.value = user.bloodGroup;
          occupationController.text = user.occupation;

          // Populate Class 10
          class10Id = user.class10.id;
          isClass10StudiedInGurukul.value = user.class10.isStudded;
          class10Branch.value = user.class10.branch ?? 'Science';
          class10PassingYear.value = user.class10.passingYear ?? '2024';
          class10Medium.value = user.class10.medium ?? 'English';
          isClass10Hostel.value = user.class10.hostel;

          // Populate Class 12
          class12Id = user.class12.id;
          isClass12StudiedInGurukul.value = user.class12.isStudded;
          class12Branch.value = user.class12.branch ?? 'Science';
          class12PassingYear.value = user.class12.passingYear ?? '2024';
          class12Medium.value = user.class12.medium ?? 'English';
          isClass12Hostel.value = user.class12.hostel;

          // Populate Addresses
          if (user.addressIds.isNotEmpty) {
            final current = user.addressIds.first;
            currentAddressController.text = current.address;
            currentCityController.text = current.city;
            currentDistrictController.text = current.district;
            currentStateController.text = current.state;
            currentPincodeController.text = current.pincode;
            currentCountry.value = current.country;
          }
          if (user.addressIds.length > 1) {
            final village = user.addressIds[1];
            villageAddressController.text = village.address;
            villageCityController.text = village.city;
            villageDistrictController.text = village.district;
            villageStateController.text = village.state;
            villagePincodeController.text = village.pincode;
            villageCountry.value = village.country;
          }

          if (user.birthDate != null) {
            try {
              final date = DateTime.parse(user.birthDate!);
              birthDateController.text = DateFormat(
                'yyyy - MM - dd',
              ).format(date);
            } catch (e) {
              birthDateController.text = user.birthDate!.split("T").first;
              log("Error parsing birthDate: $e");
            }
          }

          // Occupation mapping logic if desired
          final occ = user.occupation.toLowerCase();
          if (occ.contains("student")) isStudent.value = true;
          if (occ.contains("business")) runsBusiness.value = true;
          if (occ.contains("employee")) isEmployee.value = true;
          if (occ.contains("self")) isSelfEmployed.value = true;
          if (occ.contains("retired")) isRetired.value = true;
        }
      },
      errorMessage: "Failed to fetch alumni",
    );
  }

  void onTabChanged(int index) {
    selectedTab.value = index;
  }

  void updateAlumniProfile() {
    executeApi(
      apiCall: () async {
        // Prepare address list
        // Todo: change type accordeing to the ui. and if extra added then the type will be one of this
        /*
        export const ADDRESS_TYPE = {
    CURRENT: "current",
    VILLAGE: "village",
    SHOP: "shop",
    OFFICE: "office",
    BUSINESS: "business",
    }
        */

        final List<Map<String, dynamic>> addressList = [
          {
            "address": currentAddressController.text,
            "city": currentCityController.text,
            "district": currentDistrictController.text,
            "state": currentStateController.text,
            "country": currentCountry.value,
            "pincode": currentPincodeController.text,
            "type": "current",
          },
          {
            "address": villageAddressController.text,
            "city": villageCityController.text,
            "district": villageDistrictController.text,
            "state": villageStateController.text,
            "country": villageCountry.value,
            "pincode": villagePincodeController.text,
            "type": "village",
          },
        ];

        final body = {
          "userId": id,
          "name": nameController.text,
          "fatherName": fatherNameController.text,
          "surname": surnameController.text,
          "phoneNumber": phoneController.text,
          "whatsappNumber": whatsappNumberController.text,
          "email": emailController.text,
          "gender": gender.value,
          "hrNo": hrNumberController.text,
          "role": role.value,
          "currentCity": currentCity.value,
          "professions": professions.toList(),
          "education": educations.toList(),
          "maritalStatus": maritalStatus.value,
          "bloodGroup": bloodGroup.value,
          "occupation": occupationController.text,
          "class10": {
            "isStudded": isClass10StudiedInGurukul.value,
            "branch": class10Branch.value,
            "passingYear": class10PassingYear.value,
            "medium": class10Medium.value,
            "hostel": isClass10Hostel.value,
            "class": "10",
          },
          "class12": {
            "isStudded": isClass12StudiedInGurukul.value,
            "branch": class12Branch.value,
            "passingYear": class12PassingYear.value,
            "medium": class12Medium.value,
            "hostel": isClass12Hostel.value,
            "class": "12",
          },
          // "addresses": addressList,
        };

        if (birthDateController.text.isNotEmpty) {
          try {
            final parsedDate = DateFormat(
              'yyyy - MM - dd',
            ).parse(birthDateController.text);
            body["birthDate"] = parsedDate.toIso8601String();
          } catch (e) {
            log("Date parse error: $e");
          }
        }

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
}
