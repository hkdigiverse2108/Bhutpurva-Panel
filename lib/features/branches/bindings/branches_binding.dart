import 'package:bhutpurva_penal/features/branches/controllers/branches_controller.dart';
import 'package:get/get.dart';

class BranchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BranchesController>(() => BranchesController());
  }
}
