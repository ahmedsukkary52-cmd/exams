import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../entities/paginated_subjects_entity.dart';
import '../repo/exams_repo.dart';

@lazySingleton
class GetSubjectsUseCase {
  final ExamsRepo _examsRepo;
  GetSubjectsUseCase(this._examsRepo);

  Future<ApiResult<PaginatedSubjectsEntity>> call({required int page, int limit = 9}) async {
    return await _examsRepo.getSubjects(page: page, limit: limit);
  }
}