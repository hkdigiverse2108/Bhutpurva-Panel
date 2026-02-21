import 'dart:developer';

import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroupController extends GetxController {
  static CreateGroupController get instance => Get.find();

  final apiService = ApiService();

  final isLoading = false.obs;
  final isLeadersLoading = false.obs;
  final isBatchesLoading = false.obs;
  final nameController = TextEditingController();

  final leaders = <UserModel>[].obs;
  final selectedLeaders = <UserModel>[].obs;

  final batches = <BatchesModel>[].obs;
  final selectedBatches = <BatchesModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLeaders();
    getBatches();
  }

  void getLeaders() async {
    try {
      isLeadersLoading.value = true;
      final ResModel response = await apiService.get(ApiConstants.users());

      if (response.status == 200) {
        response.data['users'].forEach((element) {
          leaders.add(UserModel.fromJson(element));
        });
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLeadersLoading.value = false;
    }
  }

  void getBatches() async {
    try {
      isBatchesLoading.value = true;
      final ResModel response = await apiService.get(ApiConstants.batches());

      if (response.status == 200) {
        response.data['batch'].forEach((element) {
          batches.add(BatchesModel.fromJson(element));
        });
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isBatchesLoading.value = false;
    }
  }

  void createGroup() {
    isLoading.value = true;
    // TODO: implement create group
    isLoading.value = false;
  }
}
