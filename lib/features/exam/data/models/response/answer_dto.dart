import 'package:json_annotation/json_annotation.dart';

part 'answer_dto.g.dart';

@JsonSerializable()
class AnswerDto {
  @JsonKey(name: "answer")
  final String? answer;

  @JsonKey(name: "key")
  final String? key;

  AnswerDto({
    this.answer,
    this.key,
  });

  factory AnswerDto.fromJson(Map<String, dynamic> json) {
    return _$AnswerDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AnswerDtoToJson(this);
  }
}