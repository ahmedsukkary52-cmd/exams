import 'package:exams/features/exam/data/models/response/exams_response_dto.dart';

abstract class ExamsRemoteDataSource {
  Future<ExamsResponseDto> getAllExams({required int page, required int limit});
}