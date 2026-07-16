import 'exam_entity.dart';
import 'paginated_entity.dart';

class PaginatedExamsEntity extends PaginatedEntity<ExamEntity> {
  const PaginatedExamsEntity({
    required super.message,
    required super.metadata,
    required List<ExamEntity> exams,
  }) : super(items: exams);

  List<ExamEntity> get exams => items;
}