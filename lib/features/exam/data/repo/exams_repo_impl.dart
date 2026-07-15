import 'package:exams/core/network/api_result.dart';
import 'package:exams/core/network/safe_call.dart';
import 'package:exams/features/exam/data/data_sources/exams_remote_data_source.dart';
import 'package:exams/features/exam/data/mappers/paginated_exams_mapper.dart';
import 'package:exams/features/exam/domain/entities/paginated_exams_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/exams_repo.dart';

@LazySingleton(as: ExamsRepo)
class ExamsRepoImpl implements ExamsRepo {
  final ExamsRemoteDataSource _remoteDataSource;
  ExamsRepoImpl(this._remoteDataSource);
  
  @override
  Future<ApiResult<PaginatedExamsEntity>> getAllExams({required int page, required int limit}) {
    return safeCall(() async {
        final response = await _remoteDataSource.getAllExams(page:page, limit: limit);
        return Success(response.toEntity());
      },
    );
  }
  
}