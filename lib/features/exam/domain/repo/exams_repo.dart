import 'package:exams/core/network/api_result.dart';
import 'package:exams/features/exam/domain/entities/paginated_exams_entity.dart';
import 'package:exams/features/exam/domain/entities/paginated_subjects_entity.dart';

abstract class ExamsRepo {
  Future<ApiResult<PaginatedExamsEntity>> getAllExams({required int page, required int limit});
  Future<ApiResult<PaginatedSubjectsEntity>> getSubjects({required int page, required int limit});
}