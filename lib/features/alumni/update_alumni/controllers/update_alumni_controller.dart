import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateAlumniController extends BaseController {
  static UpdateAlumniController get instance => Get.find();
  final apiService = ApiService();

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
  final gender = 'Male'.obs;

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
        if (res.status == 200) {}
      },
      errorMessage: "Failed to fetch alumni",
    );
  }

  void onTabChanged(int index) {
    selectedTab.value = index;
  }
}
