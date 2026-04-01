import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/survey_models/survey_model.dart';
import 'package:bhutpurva_penal/shared/models/survey_models/survey_response_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:get/get.dart';

class SurveyResponsesController extends BaseController {
  final apiService = ApiService();

  late String surveyId;
  final surveyDetails = Rxn<SurveyModel>();
  final surveyTitle = 'Loading...'.obs;

  var responses = <SurveyResponseModel>[].obs;

  int page = 1;
  int rowsPerPage = 10;
  int total = 0;

  @override
  void onInit() {
    super.onInit();
    
    // Prioritize URL parameters for deep linking on web
    surveyId = Get.parameters['id'] ?? (Get.arguments is String ? Get.arguments : '');

    if (surveyId.isNotEmpty) {
      fetchSurveyDetails();
      fetchResponses();
    } else {
      surveyTitle.value = 'Invalid Survey';
      AppSnackBar.show(
        title: "Error",
        message: "Invalid Survey ID provided.",
        type: AppSnackBarType.error,
      );
    }
  }

  void fetchSurveyDetails() async {
    try {
      final ResModel response = await apiService.get(ApiConstants.surveyDetails(surveyId));
      if (response.status == 200) {
        final survey = SurveyModel.fromJson(response.data);
        surveyDetails.value = survey;
        surveyTitle.value = survey.title;
      } else {
        surveyTitle.value = 'Survey Not Found';
      }
    } catch (e) {
      surveyTitle.value = 'Error Loading Survey';
    }
  }

  void fetchResponses() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(
          ApiConstants.surveyResponses(surveyId, page: page, limit: rowsPerPage),
        );

        if (res.status == 200) {
          // The API returns responses in the 'responses' key and total count in 'totalData'
          final dataList = res.data['responses'] as List? ?? [];
          responses.value = dataList.map((e) => SurveyResponseModel.fromJson(e)).toList();
          total = res.data['totalData'] ?? 0;
        } else {
          responses.clear();
          total = 0;
        }
      },
      errorMessage: "Failed to fetch survey responses",
    );
  }

  void onPageChange(int newPage) {
    page = newPage;
    fetchResponses();
  }

  // Helper method to display answers properly
  String getQuestionText(String questionId) {
    if (surveyDetails.value == null) return 'Unknown Question';
    final q = surveyDetails.value!.questions.firstWhereOrNull((element) => element.id == questionId);
    return q?.questionText ?? 'Unknown Question';
  }
}
