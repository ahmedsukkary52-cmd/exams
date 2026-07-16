import 'package:json_annotation/json_annotation.dart';

import 'metadata_dto.dart';
import 'subject_dto.dart';

part 'subjects_response_dto.g.dart';

@JsonSerializable()
class SubjectsResponseDto {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "metadata")
  final MetadataDto? metadata;

  @JsonKey(name: "subjects")
  final List<SubjectDto>? subjects;

  SubjectsResponseDto({
    this.message,
    this.metadata,
    this.subjects,
  });

  factory SubjectsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$SubjectsResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubjectsResponseDtoToJson(this);
  }
}