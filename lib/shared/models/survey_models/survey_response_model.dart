import 'package:bhutpurva_penal/shared/models/user/user_model.dart';

class SurveyResponseModel {
  String id;
  String surveyId;
  UserModel? userId;
  List<AnswerModel> answers;
  DateTime? createdAt;

  SurveyResponseModel({
    required this.id,
    required this.surveyId,
    this.userId,
    required this.answers,
    this.createdAt,
  });

  factory SurveyResponseModel.fromJson(Map<String, dynamic> json) {
    return SurveyResponseModel(
      id: json['_id'] ?? '',
      surveyId: json['surveyId'] ?? '',
      userId: json['userId'] != null ? UserModel.fromJson(json['userId']) : null,
      answers: (json['answers'] as List?)
              ?.map((a) => AnswerModel.fromJson(a))
              .toList() ??
          [],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }
}

class AnswerModel {
  String questionId;
  dynamic answer;

  AnswerModel({
    required this.questionId,
    required this.answer,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      questionId: json['questionId'] ?? '',
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answer': answer,
    };
  }
}
