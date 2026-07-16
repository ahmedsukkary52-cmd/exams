import 'package:exams/features/exam/data/mappers/subject_mapper.dart';
import 'package:exams/features/exam/data/models/response/subjects_response_dto.dart';
import '../../domain/entities/paginated_subjects_entity.dart';
import '../models/response/metadata_dto.dart';
import 'metadata_mapper.dart';

extension PaginatedSubjectsMapper on SubjectsResponseDto {
  PaginatedSubjectsEntity toEntity() {
    return PaginatedSubjectsEntity(
        message: message ?? '',
        metadata: (metadata ?? MetadataDto()).toEntity(),
        subjects: subjects?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}