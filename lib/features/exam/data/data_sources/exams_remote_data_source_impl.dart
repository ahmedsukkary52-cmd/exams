import 'package:exams/core/network/api_services/api_services.dart';
import 'package:exams/features/exam/data/data_sources/exams_remote_data_source.dart';
import 'package:exams/features/exam/data/models/response/exams_response_dto.dart';
import 'package:exams/features/exam/data/models/response/subjects_response_dto.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: ExamsRemoteDataSource)
class ExamsRemoteDataSourceImpl implements ExamsRemoteDataSource {
  final ApiServices _apiServices;
  ExamsRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ExamsResponseDto> getAllExams({required int page, required int limit}) async {
    return await _apiServices.getAllExams(
      page: page,
      limit: limit,
    );
  }

  @override
  Future<SubjectsResponseDto> getSubjects({required int page, required int limit}) async {
    return await _apiServices.getSubjects(page: page, limit: limit);
  }
}