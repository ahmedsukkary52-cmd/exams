import 'package:exams/features/exam/data/models/response/exams_response_dto.dart';
import '../../domain/entities/paginated_exams_entity.dart';
import '../models/response/metadata_dto.dart';
import 'exam_mapper.dart';
import 'metadata_mapper.dart';

extension ExamsResponseDtoMapper on ExamsResponseDto {
  PaginatedExamsEntity toEntity() {
    return PaginatedExamsEntity(
      message: message ?? '',
      metadata: (metadata ?? MetadataDto()).toEntity(),
      exams: exams?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}