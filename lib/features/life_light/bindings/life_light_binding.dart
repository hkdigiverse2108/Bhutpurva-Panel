import 'package:bhutpurva_penal/features/life_light/controllers/life_light_controller.dart';
import 'package:get/get.dart';

class LifeLightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LifeLightController>(() => LifeLightController());
  }
}
