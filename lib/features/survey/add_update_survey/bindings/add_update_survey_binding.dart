import 'package:bhutpurva_penal/features/survey/add_update_survey/controllers/add_update_survey_controller.dart';
import 'package:get/get.dart';

class AddUpdateSurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUpdateSurveyController>(() => AddUpdateSurveyController());
  }
}
