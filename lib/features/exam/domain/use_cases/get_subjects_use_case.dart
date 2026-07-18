import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../entities/subjects_response_entity.dart';
import '../repo/exams_repo.dart';

@lazySingleton
class GetSubjectsUseCase {
  final ExamsRepo _examsRepo;
  GetSubjectsUseCase(this._examsRepo);

  Future<ApiResult<SubjectsResponseEntity>> call({int page = 1, int limit = 9}) async {
    return await _examsRepo.getSubjects(page: page, limit: limit);
  }
}