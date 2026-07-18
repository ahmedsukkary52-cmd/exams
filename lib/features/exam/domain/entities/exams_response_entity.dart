import 'exam_entity.dart';
import 'metadata_entity.dart';
import 'response_entity.dart';

class ExamsResponseEntity extends ResponseEntity<ExamEntity> {
  const ExamsResponseEntity({
    required super.message,
    required super.metadata,
    required List<ExamEntity> exams,
  }) : super(items: exams);

  List<ExamEntity> get exams => items;

  ExamsResponseEntity copyWith({
    String? message,
    MetadataEntity? metadata,
    List<ExamEntity>? exams,
  }) {
    return ExamsResponseEntity(
      message: message ?? this.message,
      metadata: metadata ?? this.metadata,
      exams: exams ?? this.exams,
    );
  }
}