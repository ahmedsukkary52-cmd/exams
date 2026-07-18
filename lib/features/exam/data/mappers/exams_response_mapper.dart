import 'package:exams/features/exam/data/models/response/exams_response_dto.dart';
import '../../domain/entities/exams_response_entity.dart';
import '../models/response/metadata_dto.dart';
import 'exam_mapper.dart';
import 'metadata_mapper.dart';

extension ExamsResponseDtoMapper on ExamsResponseDto {
  ExamsResponseEntity toEntity() {
    return ExamsResponseEntity(
      message: message ?? '',
      metadata: (metadata ?? MetadataDto()).toEntity(),
      exams: exams?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}