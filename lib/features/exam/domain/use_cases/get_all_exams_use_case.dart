import 'package:exams/core/network/api_result.dart';
import 'package:exams/features/exam/domain/entities/paginated_exams_entity.dart';
import 'package:exams/features/exam/domain/repo/exams_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllExamsUseCase {
  final ExamsRepo _examsRepo;
  GetAllExamsUseCase(this._examsRepo);

  Future<ApiResult<PaginatedExamsEntity>> call({required int page, int limit = 9}) async {
    return await _examsRepo.getAllExams(page: page, limit: limit);
  }
}