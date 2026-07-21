import 'package:exams/features/exam/data/models/response/exams_response_dto.dart';
import 'package:exams/features/exam/data/models/response/subjects_response_dto.dart';
import '../models/response/questions_response_dto.dart';

abstract class ExamsRemoteDataSource {
  Future<ExamsResponseDto> getAllExams({required int page, required int limit});
  Future<ExamsResponseDto> getExamsBySubject({required String subjectId,required int page, required int limit});

  Future<SubjectsResponseDto> getSubjects({required int page, required int limit});

  Future<QuestionsResponseDto> getQuestionsByExam({required String examId});
}