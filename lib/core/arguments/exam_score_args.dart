import '../../features/exam/domain/entities/question_entity.dart';

class ExamScoreArgs {
  final List<QuestionEntity> questions;
  final Map<String, Set<String>> selectedAnswers;

  const ExamScoreArgs({
    required this.questions,
    required this.selectedAnswers,
  });
}