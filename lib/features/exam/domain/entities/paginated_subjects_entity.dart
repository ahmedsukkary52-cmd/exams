import 'package:exams/features/exam/domain/entities/paginated_entity.dart';
import 'package:exams/features/exam/domain/entities/subject_entity.dart';

class PaginatedSubjectsEntity extends PaginatedEntity<SubjectEntity> {
  PaginatedSubjectsEntity({
    required super.message,
    required super.metadata,
    required List<SubjectEntity> subjects,
  }):super(items: subjects);

  List<SubjectEntity> get subjects => items;
}