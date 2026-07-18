import 'package:exams/core/network/api_result.dart';
import 'package:injectable/injectable.dart';
import '../entities/exams_response_entity.dart';
import '../repo/exams_repo.dart';

@singleton
class GetExamsBySubjectUseCase {
  final ExamsRepo _examsRepo;
  GetExamsBySubjectUseCase(this._examsRepo);

  Future<ApiResult<ExamsResponseEntity>> call({required String subjectId, int page = 1, int limit = 9}) async {
    return await _examsRepo.getExamsBySubject(subjectId: subjectId, page: page, limit: limit);
  }
}