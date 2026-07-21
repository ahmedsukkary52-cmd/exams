import '../../../../core/enums/question_type.dart';
import 'answer_entity.dart';
import 'exam_entity.dart';
import 'subject_entity.dart';

class QuestionEntity {
  final String id;
  final String question;
  final List<AnswerEntity> answers;
  final QuestionType type;
  final String correct;
  final SubjectEntity subject;
  final ExamEntity exam;
  final DateTime createdAt;

  const QuestionEntity({
    required this.id,
    required this.question,
    required this.answers,
    required this.type,
    required this.correct,
    required this.subject,
    required this.exam,
    required this.createdAt,
  });

  QuestionEntity copyWith({
    String? id,
    String? question,
    List<AnswerEntity>? answers,
    QuestionType? type,
    String? correct,
    SubjectEntity? subject,
    ExamEntity? exam,
    DateTime? createdAt,
  }) {
    return QuestionEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      type: type ?? this.type,
      correct: correct ?? this.correct,
      subject: subject ?? this.subject,
      exam: exam ?? this.exam,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}