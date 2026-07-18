import 'package:exams/features/exam/domain/entities/response_entity.dart';
import 'package:exams/features/exam/domain/entities/subject_entity.dart';

import 'metadata_entity.dart';

class SubjectsResponseEntity extends ResponseEntity<SubjectEntity> {
  SubjectsResponseEntity({
    required super.message,
    required super.metadata,
    required List<SubjectEntity> subjects,
  }):super(items: subjects);

  List<SubjectEntity> get subjects => items;

  SubjectsResponseEntity copyWith({
    String? message,
    MetadataEntity? metadata,
    List<SubjectEntity>? subjects,
  }) {
    return SubjectsResponseEntity(
      message: message ?? this.message,
      metadata: metadata ?? this.metadata,
      subjects: subjects ?? this.subjects,
    );
  }
}