import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/shared/models/devotee_model/devotee_model.dart';
import 'package:bhutpurva_penal/shared/models/student_model/student_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBatchController extends GetxController {
  static CreateBatchController get instance => Get.find();

  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final devotees = <MoniterModel>[
    MoniterModel(
      name: 'John Doe',
      address: '123 Main St',
      phone: '123-456-7890',
      email: 'john.doe@example.com',
      id: '1',
    ),  
    MoniterModel(
      name: 'Jane Smith',
      address: '456 Maple St',
      phone: '456-789-0123',
      email: 'jane.smith@example.com',
      id: '2',
    ),
    MoniterModel(
      name: 'Alice Johnson',
      address: '789 Elm St',
      phone: '789-012-3456',
      email: 'alice.johnson@example.com',
      id: '3',
    ),
    MoniterModel(
      name: 'Bob Wilson',
      address: '101 Oak St',
      phone: '101-234-5678',
      email: 'bob.wilson@example.com',
      id: '4',
    ),
  ].obs;

  final selectedDevotees = <MoniterModel>[].obs;

  final students = <StudentModel>[].obs;

  final selectedStudents = <StudentModel>[].obs;

  void createBatch() {
    try {
      if (formKey.currentState!.validate()) {
        AppSnackBar.show(
          title: "Success",
          message: "Batch created successfully",
          type: AppSnackBarType.success,
        );
      }
    } catch (e) {
      AppSnackBar.show(
        title: "Error",
        message: "Failed to create batch",
        type: AppSnackBarType.error,
      );
    }
  }
}
