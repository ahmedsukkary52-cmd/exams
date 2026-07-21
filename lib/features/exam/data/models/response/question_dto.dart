import 'package:json_annotation/json_annotation.dart';

import 'answer_dto.dart';
import 'exam_dto.dart';
import 'subject_dto.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "question")
  final String? question;

  @JsonKey(name: "answers")
  final List<AnswerDto>? answers;

  @JsonKey(name: "type")
  final String? type;

  @JsonKey(name: "correct")
  final String? correct;

  @JsonKey(name: "subject")
  final SubjectDto? subject;

  @JsonKey(name: "exam")
  final ExamDto? exam;

  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  QuestionDto({
    this.id,
    this.question,
    this.answers,
    this.type,
    this.correct,
    this.subject,
    this.exam,
    this.createdAt,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) {
    return _$QuestionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuestionDtoToJson(this);
  }
}