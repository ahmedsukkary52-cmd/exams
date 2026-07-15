import '../../domain/entities/metadata_entity.dart';
import '../models/response/metadata_dto.dart';

extension MetadataDtoMapper on MetadataDto {
  MetadataEntity toEntity() {
    return MetadataEntity(
      currentPage: currentPage ?? 0,
      numberOfPages: numberOfPages ?? 0,
      limit: limit ?? 0,
    );
  }
}