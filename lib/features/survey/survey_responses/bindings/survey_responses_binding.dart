import 'package:bhutpurva_penal/features/survey/survey_responses/controllers/survey_responses_controller.dart';
import 'package:get/get.dart';

class SurveyResponsesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyResponsesController>(() => SurveyResponsesController());
  }
}
