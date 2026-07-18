import 'package:exams/features/exam/domain/entities/subjects_response_entity.dart';
import '../../../../core/base/resources.dart';
import '../../domain/entities/exams_response_entity.dart';

class ExamsState {
  final Resource<ExamsResponseEntity> examsResource;
  final Resource<ExamsResponseEntity> examsBySubjectsResource;
  final Resource<SubjectsResponseEntity> subjectsResource;

  final bool isLoadingMoreExams;
  final bool isLoadingMoreSubjects;
  final bool isLoadingMoreExamsBySubjects;

  const ExamsState({
    required this.examsResource,
    required this.subjectsResource,
    required this.examsBySubjectsResource,
    required this.isLoadingMoreExams,
    required this.isLoadingMoreSubjects,
    required this.isLoadingMoreExamsBySubjects,
  });

  ExamsState copyWith({
    Resource<ExamsResponseEntity>? examsResource,
    Resource<SubjectsResponseEntity>? subjectsResource,
    Resource<ExamsResponseEntity>? examsBySubjectsResource,
    bool? isLoadingMoreExams,
    bool? isLoadingMoreSubjects,
    bool? isLoadingMoreExamsBySubjects,
  }) {
    return ExamsState(
      examsResource: examsResource ?? this.examsResource,
      subjectsResource:
      subjectsResource ?? this.subjectsResource,
      examsBySubjectsResource:
      examsBySubjectsResource ?? this.examsBySubjectsResource,
      isLoadingMoreExams:
      isLoadingMoreExams ?? this.isLoadingMoreExams,
      isLoadingMoreSubjects:
      isLoadingMoreSubjects ?? this.isLoadingMoreSubjects,
      isLoadingMoreExamsBySubjects:
      isLoadingMoreExamsBySubjects ?? this.isLoadingMoreExamsBySubjects,
    );
  }
}