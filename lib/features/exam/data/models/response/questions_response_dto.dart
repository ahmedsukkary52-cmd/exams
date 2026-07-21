import 'package:json_annotation/json_annotation.dart';

import 'question_dto.dart';

part 'questions_response_dto.g.dart';

@JsonSerializable()
class QuestionsResponseDto {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "questions")
  final List<QuestionDto>? questions;

  QuestionsResponseDto({
    this.message,
    this.questions,
  });

  factory QuestionsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$QuestionsResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuestionsResponseDtoToJson(this);
  }
}