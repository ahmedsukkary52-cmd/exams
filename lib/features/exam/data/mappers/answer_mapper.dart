import '../../domain/entities/answer_entity.dart';
import '../models/response/answer_dto.dart';

extension AnswerMapper on AnswerDto {
  AnswerEntity toEntity() {
    return AnswerEntity(
      answer: answer ?? '',
      key: key ?? '',
    );
  }
}

extension AnswerDtoListMapper on List<AnswerDto> {
  List<AnswerEntity> toEntityList() => map((answer) => answer.toEntity()).toList();
}