import 'package:exams/core/network/api_result.dart';
import 'package:exams/core/network/safe_call.dart';
import 'package:exams/features/exam/data/data_sources/exams_remote_data_source.dart';
import 'package:exams/features/exam/data/mappers/exams_response_mapper.dart';
import 'package:exams/features/exam/data/mappers/subjects_response_mapper.dart';
import 'package:exams/features/exam/domain/entities/exams_response_entity.dart';
import 'package:exams/features/exam/domain/entities/questions_response_entity.dart';
import 'package:exams/features/exam/domain/entities/subjects_response_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo/exams_repo.dart';
import '../mappers/questions_response_mapper.dart';

@LazySingleton(as: ExamsRepo)
class ExamsRepoImpl implements ExamsRepo {
  final ExamsRemoteDataSource _remoteDataSource;
  ExamsRepoImpl(this._remoteDataSource);
  
  @override
  Future<ApiResult<ExamsResponseEntity>> getAllExams({required int page, required int limit}) {
    return safeCall(() async {
        final response = await _remoteDataSource.getAllExams(page:page, limit: limit);
        return Success(response.toEntity());
      },
    );
  }

  @override
  Future<ApiResult<SubjectsResponseEntity>> getSubjects({required int page, required int limit}) {
    return safeCall(() async {
        final response = await _remoteDataSource.getSubjects(page: page, limit: limit);
        return Success(response.toEntity());
      },
    );
  }

  @override
  Future<ApiResult<ExamsResponseEntity>> getExamsBySubject({required String subjectId, required int page, required int limit}) {
    return safeCall(() async {
      final response = await _remoteDataSource.getExamsBySubject(subjectId: subjectId, page: page, limit: limit);
      return Success(response.toEntity());
    },);
  }

  @override
  Future<ApiResult<QuestionsResponseEntity>> getQuestionsByExam({required String examId}) {
    return safeCall(() async {
      final response = await _remoteDataSource.getQuestionsByExam(examId: examId);
      return Success(response.toEntity());
    },);
  }
}