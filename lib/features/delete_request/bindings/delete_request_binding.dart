import 'package:bhutpurva_penal/features/delete_request/controllers/delete_request_controller.dart';
import 'package:get/get.dart';

class DeleteRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeleteRequestController());
  }
}
