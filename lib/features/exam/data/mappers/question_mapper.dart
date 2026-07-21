import '../../../../core/enums/question_type.dart';
import '../../domain/entities/exam_entity.dart';
import '../../domain/entities/question_entity.dart';
import '../../domain/entities/subject_entity.dart';
import '../models/response/question_dto.dart';
import 'answer_mapper.dart';
import 'exam_mapper.dart';
import 'subject_mapper.dart';

extension QuestionMapper on QuestionDto {
  QuestionEntity toEntity() {
    return QuestionEntity(
      id: id ?? '',
      question: question ?? '',
      answers: answers?.toEntityList() ?? [],
      type: QuestionType.fromString(questionTypeStr: type ?? 'single_choice'),
      correct: correct ?? '',
      subject: subject?.toEntity() ?? SubjectEntity.empty(),
      exam: exam?.toEntity() ?? ExamEntity.empty(),
      createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

extension QuestionDtoListMapper on List<QuestionDto> {
  List<QuestionEntity> toEntityList() => map((question) => question.toEntity()).toList();
}