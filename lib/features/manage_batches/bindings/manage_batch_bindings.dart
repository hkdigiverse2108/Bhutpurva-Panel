import 'package:bhutpurva_penal/features/manage_batches/batch_details/controllers/batch_details_controller.dart';
import 'package:bhutpurva_penal/features/manage_batches/batch_list/controllers/batch_list_controller.dart';
import 'package:bhutpurva_penal/features/manage_batches/create_batch/controllers/create_batch_controller.dart';
import 'package:get/get.dart';

class ManageBatchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BatchListController>(() => BatchListController());
    Get.lazyPut<CreateBatchController>(() => CreateBatchController());
    Get.lazyPut<BatchDetailsController>(() => BatchDetailsController());
  }
}
