import 'package:bhutpurva_penal/features/programs/create_program/controllers/create_program_controller.dart';
import 'package:bhutpurva_penal/features/programs/edit_program/controllers/edit_program_controller.dart';
import 'package:bhutpurva_penal/features/programs/program_details/controllers/program_detail_controller.dart';
import 'package:bhutpurva_penal/features/programs/program_list/controllers/program_list_controller.dart';
import 'package:get/get.dart';

class ProgramBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProgramListController());
    Get.lazyPut(() => CreateProgramController());
    Get.lazyPut(() => EditProgramController());
    Get.lazyPut(() => ProgramDetailController());
  }
}
