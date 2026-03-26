class SurveyModel {
  String id;
  String title;
  String description;
  String scope;
  String? groupId;
  String? batchId;
  List<QuestionModel> questions;
  bool isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.scope,
    this.groupId,
    this.batchId,
    required this.questions,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });
  
  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      scope: json['scope'] ?? 'overall',
      groupId: json['groupId'],
      batchId: json['batchId'],
      questions:
          (json['questions'] as List?)
              ?.map((q) => QuestionModel.fromJson(q))
              .toList() ??
          [],
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) '_id': id,
      'title': title,
      'description': description,
      'scope': scope,
      if (groupId != null) 'groupId': groupId,
      if (batchId != null) 'batchId': batchId,
      'questions': questions.map((q) => q.toJson()).toList(),
      'isActive': isActive,
    };
  }
}

class QuestionModel {
  String id;
  String questionText;
  String questionType;
  List<String> options;
  bool isRequired;

  QuestionModel({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.options,
    this.isRequired = true,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['_id'] ?? json['id'] ?? '',
      questionText: json['questionText'] ?? '',
      questionType: json['questionType'] ?? 'text',
      options: List<String>.from(json['options'] ?? []),
      isRequired: json['isRequired'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) '_id': id,
      'questionText': questionText,
      'questionType': questionType,
      'options': options,
      'isRequired': isRequired,
    };
  }
}
