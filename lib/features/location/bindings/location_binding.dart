import 'package:bhutpurva_penal/features/location/controllers/location_controller.dart';
import 'package:get/get.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationController());
  }
}
