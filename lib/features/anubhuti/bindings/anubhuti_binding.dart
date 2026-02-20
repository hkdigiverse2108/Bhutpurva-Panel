import 'package:bhutpurva_penal/features/anubhuti/controllers/anubhuti_controller.dart';
import 'package:get/get.dart';

class AnubhutiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnubhutiController>(() => AnubhutiController());
  }
}
