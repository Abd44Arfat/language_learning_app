class QuestionsResponse {
  final List<QuestionModel> data;
  final String message;
  final String status;

  QuestionsResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) {
    return QuestionsResponse(
      data: (json['data'] as List)
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
      message: json['message'],
      status: json['status'],
    );
  }
}

class QuestionModel {
  final int id;
  final String questionContent;
  final String questionType;
  final String answerType;
  final int sectionId;
  final List<ChoiceModel> choices;

  QuestionModel({
    required this.id,
    required this.questionContent,
    required this.questionType,
    required this.answerType,
    required this.sectionId,
    required this.choices,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      questionContent: json['question_content'],
      questionType: json['question_type'],
      answerType: json['answer_type'],
      sectionId: json['section_id'],
      choices: (json['choices'] as List)
          .map((e) => ChoiceModel.fromJson(e))
          .toList(),
    );
  }
}

class ChoiceModel {
  final int id;
  final String choiceType;
  final String content;
  final bool isCorrect;

  ChoiceModel({
    required this.id,
    required this.choiceType,
    required this.content,
    required this.isCorrect,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) {
    return ChoiceModel(
      id: json['id'],
      choiceType: json['choice_type'],
      content: json['content'],
      isCorrect: json['is_correct'],
    );
  }
}
