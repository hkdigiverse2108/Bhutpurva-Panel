import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateAlumniController extends GetxController {
  static UpdateAlumniController get instance => Get.find();

  final isLoading = false.obs;

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

  void onTabChanged(int index) {
    selectedTab.value = index;
  }
}
