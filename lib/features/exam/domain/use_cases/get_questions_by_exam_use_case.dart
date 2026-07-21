import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../entities/questions_response_entity.dart';
import '../repo/exams_repo.dart';

@injectable
class GetQuestionsByExamUseCase {
  final ExamsRepo _examsRepo;
  GetQuestionsByExamUseCase(this._examsRepo);
  Future<ApiResult<QuestionsResponseEntity>> call({required String examId}) async {
    return await _examsRepo.getQuestionsByExam(examId: examId);
  }
}