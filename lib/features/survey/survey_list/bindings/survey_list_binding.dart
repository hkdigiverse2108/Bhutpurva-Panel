import 'package:bhutpurva_penal/features/survey/survey_list/controllers/survey_list_controller.dart';
import 'package:get/get.dart';

class SurveyListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyListController>(() => SurveyListController());
  }
}
