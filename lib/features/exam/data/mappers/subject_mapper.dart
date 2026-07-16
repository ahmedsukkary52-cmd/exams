import 'package:exams/features/exam/data/models/response/subject_dto.dart';
import '../../domain/entities/subject_entity.dart';

extension SubjectMapper on SubjectDto {
  SubjectEntity toEntity() {
    return SubjectEntity(
      id: id ?? '',
      name: name ?? '',
      icon: icon ?? '',
      createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

extension SubjectListMapper on List<SubjectDto> {
  List<SubjectEntity> toEntityList() => map((subject) => subject.toEntity()).toList();
}