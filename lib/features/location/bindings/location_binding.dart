import 'package:bhutpurva_penal/features/location/create_location/controllers/create_location_controller.dart';
import 'package:bhutpurva_penal/features/location/location_list/controllers/location_controller.dart';
import 'package:get/get.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationController());
    Get.lazyPut(() => CreateLocationController());
  }
}
