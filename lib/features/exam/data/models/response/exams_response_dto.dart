import 'package:json_annotation/json_annotation.dart';

import 'exam_dto.dart';
import 'metadata_dto.dart';

part 'exams_response_dto.g.dart';

@JsonSerializable()
class ExamsResponseDto {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "metadata")
  final MetadataDto? metadata;

  @JsonKey(name: "exams")
  final List<ExamDto>? exams;

  ExamsResponseDto({
    this.message,
    this.metadata,
    this.exams,
  });

  factory ExamsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ExamsResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamsResponseDtoToJson(this);
  }
}