import 'package:exams/features/exam/domain/entities/paginated_subjects_entity.dart';
import 'package:exams/features/exam/domain/entities/subject_entity.dart';

import '../../../../core/base/meta_resources.dart';
import '../../../../core/base/resources.dart';
import '../../domain/entities/exam_entity.dart';
import '../../domain/entities/paginated_exams_entity.dart';

class ExamsState {
  final Resource<List<ExamEntity>> examsResource;
  final MetaResource<PaginatedExamsEntity> metaExams;

  final Resource<List<SubjectEntity>> subjectsResource;
  final MetaResource<PaginatedSubjectsEntity> metaSubjects;


  const ExamsState({
    required this.examsResource,
    required this.metaExams,
    required this.subjectsResource,
    required this.metaSubjects,
  });

  ExamsState copyWith({
    Resource<List<ExamEntity>>? examsResource,
    MetaResource<PaginatedExamsEntity>? metaExams,
    Resource<List<SubjectEntity>>? subjectsResource,
    MetaResource<PaginatedSubjectsEntity>? metaSubjects,
  }) {
    return ExamsState(
      examsResource: examsResource ?? this.examsResource,
      metaExams: metaExams ?? this.metaExams,
      subjectsResource: subjectsResource ?? this.subjectsResource,
      metaSubjects: metaSubjects ?? this.metaSubjects,
    );
  }
}