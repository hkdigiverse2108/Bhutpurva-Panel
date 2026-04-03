import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/group_models/group_model.dart';
import 'package:bhutpurva_penal/shared/models/batche_model/batches_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/survey_models/survey_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUpdateSurveyController extends BaseController {
  final apiService = ApiService();
  final formKey = GlobalKey<FormState>();

  String? surveyId;
  String? prefilledScope;
  String? prefilledGroupId;
  String? prefilledBatchId;
  final isEditMode = false.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final scopeValue = 'overall'.obs;

  final groups = <GroupDropdownModel>[].obs;
  final selectedGroupId = RxnString();
  final isGroupsLoading = false.obs;

  final batches = <BatchesModel>[].obs;
  final selectedBatchId = RxnString();
  final isBatchesLoading = false.obs;

  final questions = <QuestionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      if (args.containsKey('id')) {
        surveyId = args['id'];
      } else {
        prefilledScope = args['scope'];
        prefilledGroupId = args['groupId'];
        prefilledBatchId = args['batchId'];
      }
    } else if (args is String) {
      surveyId = args;
    }

    if (surveyId != null) {
      isEditMode(true);
      fetchSurveyDetails();
    } else {
      if (prefilledScope != null) {
        scopeValue.value = prefilledScope!;
        if (prefilledScope == 'group') {
          selectedGroupId.value = prefilledGroupId;
          getGroups();
        } else if (prefilledScope == 'batch') {
          selectedBatchId.value = prefilledBatchId;
          getBatches();
        }
      }
      addQuestion();
    }
  }

  void fetchSurveyDetails() {
    executeApi(
      apiCall: () async {
        final ResModel response = await apiService.get(
          ApiConstants.surveyDetails(surveyId!),
        );
        if (response.status == 200) {
          final data = SurveyModel.fromJson(response.data);
          titleController.text = data.title;
          descriptionController.text = data.description;
          scopeValue.value = data.scope;
          selectedGroupId.value = data.groupId;
          selectedBatchId.value = data.batchId;
          questions.value = data.questions;

          if (data.scope == 'group') {
            await getGroups();
          } else if (data.scope == 'batch') {
            await getBatches();
          }
        }
      },
      errorMessage: "Failed to fetch survey details",
    );
  }

  Future<void> getGroups() async {
    isGroupsLoading(true);
    try {
      final response = await apiService.get(ApiConstants.groupsDropdown(""));
      if (response.status == 200) {
        final list = response.data ?? [];
        groups.assignAll(
          (list as Iterable)
              .map<GroupDropdownModel>((e) => GroupDropdownModel.fromJson(e))
              .toList(),
        );
      }
    } finally {
      isGroupsLoading(false);
    }
  }

  Future<void> getBatches() async {
    isBatchesLoading(true);
    try {
      final response = await apiService.get(
        ApiConstants.dropdownBatches(query: ""),
      );
      if (response.status == 200) {
        final list = response.data ?? [];
        batches.assignAll(
          (list as Iterable)
              .map<BatchesModel>((e) => BatchesModel.fromJson(e))
              .toList(),
        );
      }
    } finally {
      isBatchesLoading(false);
    }
  }

  void onScopeChanged(String? val) {
    if (val != null) {
      scopeValue.value = val;
      selectedGroupId.value = null;
      selectedBatchId.value = null;
      if (val == 'group' && groups.isEmpty) {
        getGroups();
      } else if (val == 'batch' && batches.isEmpty) {
        getBatches();
      }
    }
  }

  void addQuestion() {
    questions.add(
      QuestionModel(
        id: DateTime.now().millisecondsSinceEpoch
            .toString(), // Temporary ID for UI
        questionText: '',
        questionType: 'text',
        options: [],
      ),
    );
  }

  void removeQuestion(int index) {
    if (questions.length > 1) {
      questions.removeAt(index);
    }
  }

  void updateQuestionText(int index, String text) {
    questions[index].questionText = text;
  }

  void updateQuestionType(int index, String? type) {
    if (type != null) {
      questions[index].questionType = type;
      if (type != 'single_choice' &&
          type != 'multiple_choice' &&
          type != 'dropdown') {
        questions[index].options.clear();
      } else if (questions[index].options.isEmpty) {
        questions[index].options.add('');
      }
      questions.refresh();
    }
  }

  void toggleQuestionRequired(int index, bool? val) {
    if (val != null) {
      questions[index].isRequired = val;
      questions.refresh();
    }
  }

  void addOption(int questionIndex) {
    questions[questionIndex].options.add('');
    questions.refresh();
  }

  void removeOption(int questionIndex, int optionIndex) {
    if (questions[questionIndex].options.length > 1) {
      questions[questionIndex].options.removeAt(optionIndex);
      questions.refresh();
    }
  }

  void updateOptionText(int questionIndex, int optionIndex, String text) {
    questions[questionIndex].options[optionIndex] = text;
  }

  void saveSurvey() {
    if (!formKey.currentState!.validate()) return;

    for (var i = 0; i < questions.length; i++) {
      var q = questions[i];
      if (q.questionText.trim().isEmpty) {
        AppSnackBar.show(
          title: "Error",
          message: "Question ${i + 1} text cannot be empty",
          type: AppSnackBarType.error,
        );
        return;
      }
      if ([
        'single_choice',
        'multiple_choice',
        'dropdown',
      ].contains(q.questionType)) {
        for (var opt in q.options) {
          if (opt.trim().isEmpty) {
            AppSnackBar.show(
              title: "Error",
              message: "Options for Question ${i + 1} cannot be empty",
              type: AppSnackBarType.error,
            );
            return;
          }
        }
      }
    }

    if (scopeValue.value == 'group' && selectedGroupId.value == null) {
      AppSnackBar.show(
        title: "Error",
        message: "Please select a group",
        type: AppSnackBarType.error,
      );
      return;
    }
    if (scopeValue.value == 'batch' && selectedBatchId.value == null) {
      AppSnackBar.show(
        title: "Error",
        message: "Please select a batch",
        type: AppSnackBarType.error,
      );
      return;
    }

    final body = {
      if (isEditMode.value) 'surveyId': surveyId,
      'title': titleController.text,
      'description': descriptionController.text,
      'scope': scopeValue.value,
      if (scopeValue.value == 'group') 'groupId': selectedGroupId.value,
      if (scopeValue.value == 'batch') 'batchId': selectedBatchId.value,
      'questions': questions
          .map(
            (q) => {
              'questionText': q.questionText,
              'questionType': q.questionType,
              'options': q.options,
              'isRequired': q.isRequired,
              if (isEditMode.value && !q.id.contains(RegExp(r'^\d+$')))
                '_id': q.id,
            },
          )
          .toList(),
      'isActive': true,
    };

    executeApi(
      apiCall: () async {
        final ResModel response = await (isEditMode.value
            ? apiService.put(ApiConstants.updateSurvey, body: body)
            : apiService.post(ApiConstants.createSurvey, body: body));

        if (response.status == 200 || response.status == 201) {
          Get.back(result: true);
          AppSnackBar.show(
            title: "Success",
            message: isEditMode.value ? "Survey updated" : "Survey created",
            type: AppSnackBarType.success,
          );
        } else {
          AppSnackBar.show(
            title: "Error",
            message: response.message ?? "Failed to save survey",
            type: AppSnackBarType.error,
          );
        }
      },
      errorMessage: "Could not save survey",
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
