import '../../domain/entities/questions_response_entity.dart';
import '../models/response/questions_response_dto.dart';

import 'question_mapper.dart';

extension QuestionsResponseMapper on QuestionsResponseDto {
  QuestionsResponseEntity toEntity() {
    return QuestionsResponseEntity(
      message: message ?? '',
      questions: questions?.toEntityList() ?? const [],
    );
  }
}