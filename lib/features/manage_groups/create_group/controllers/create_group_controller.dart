import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/leader_models/leader_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroupController extends GetxController {
  static CreateGroupController get instance => Get.find();

  final isLoading = false.obs;
  final nameController = TextEditingController();

  final leaders = <LeaderModel>[
    LeaderModel(
      name: 'Leader 1',
      email: 'leader1@gmail.com',
      phone: '1234567890',
    ),
    LeaderModel(
      name: 'Leader 2',
      email: 'leader2@gmail.com',
      phone: '1234567890',
    ),
    LeaderModel(
      name: 'Leader 3',
      email: 'leader3@gmail.com',
      phone: '1234567890',
    ),
  ].obs;
  final selectedLeaders = <LeaderModel>[].obs;

  final batches = <BatchesModel>[
    BatchesModel(id: '1', name: 'Batch 1', students: [], monitor: 'Leader 1'),
    BatchesModel(id: '2', name: 'Batch 2', students: [], monitor: 'Leader 2'),
    BatchesModel(id: '3', name: 'Batch 3', students: [], monitor: 'Leader 3'),
  ].obs;
  final selectedBatches = <BatchesModel>[].obs;

  void createGroup() {
    isLoading.value = true;
    // TODO: implement create group
    isLoading.value = false;
  }
}
