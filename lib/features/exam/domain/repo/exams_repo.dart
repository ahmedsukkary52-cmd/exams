import 'package:exams/core/network/api_result.dart';
import 'package:exams/features/exam/domain/entities/exams_response_entity.dart';
import 'package:exams/features/exam/domain/entities/subjects_response_entity.dart';

abstract class ExamsRepo {
  Future<ApiResult<ExamsResponseEntity>> getAllExams({required int page, required int limit});
  Future<ApiResult<ExamsResponseEntity>> getExamsBySubject({required String subjectId,required int page, required int limit});

  Future<ApiResult<SubjectsResponseEntity>> getSubjects({required int page, required int limit});
}