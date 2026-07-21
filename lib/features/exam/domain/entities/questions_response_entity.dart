import 'question_entity.dart';

class QuestionsResponseEntity {
  final String message;
  final List<QuestionEntity> questions;

  const QuestionsResponseEntity({
    required this.message,
    required this.questions,
  });

  QuestionsResponseEntity copyWith({
    String? message,
    List<QuestionEntity>? questions,
  }) {
    return QuestionsResponseEntity(
      message: message ?? this.message,
      questions: questions ?? this.questions,
    );
  }
}