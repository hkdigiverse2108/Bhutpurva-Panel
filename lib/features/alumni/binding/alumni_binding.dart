import 'package:bhutpurva_penal/features/alumni/all_alumni/controllers/all_alumni_controller.dart';
import 'package:bhutpurva_penal/features/alumni/update_alumni/controllers/update_alumni_controller.dart';
import 'package:get/get.dart';

class AlumniBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllAlumniController>(() => AllAlumniController());
    Get.lazyPut<UpdateAlumniController>(() => UpdateAlumniController());
  }
}
