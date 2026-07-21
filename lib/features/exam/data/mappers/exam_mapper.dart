import '../../domain/entities/exam_entity.dart';
import '../models/response/exam_dto.dart';

extension ExamDtoMapper on ExamDto {
  ExamEntity toEntity() {
    return ExamEntity(
      id: id ?? '',
      title: title ?? '',
      duration: duration ?? 0,
      subjectId: subject ?? '',
      numberOfQuestions: numberOfQuestions ?? 0,
      active: active ?? false,
      createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

extension ExamDtoListMapper on List<ExamDto> {
  List<ExamEntity> toEntityList() => map((exam) => exam.toEntity()).toList();
}