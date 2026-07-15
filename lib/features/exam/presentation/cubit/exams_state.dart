import '../../../../core/base/meta_resources.dart';
import '../../../../core/base/resources.dart';
import '../../domain/entities/exam_entity.dart';
import '../../domain/entities/paginated_exams_entity.dart';

class ExamsState {
  final Resource<List<ExamEntity>> examsResource;
  final MetaResource<PaginatedExamsEntity> paginationResource;

  const ExamsState({
    required this.examsResource,
    required this.paginationResource,
  });

  ExamsState copyWith({
    Resource<List<ExamEntity>>? examsResource,
    MetaResource<PaginatedExamsEntity>? paginationResource,
  }) {
    return ExamsState(
      examsResource: examsResource ?? this.examsResource,
      paginationResource: paginationResource ?? this.paginationResource,
    );
  }
}