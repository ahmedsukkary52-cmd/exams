import 'metadata_entity.dart';

abstract class PaginatedEntity<T> {
  final String message;
  final MetadataEntity metadata;
  final List<T> items;

  const PaginatedEntity({
    required this.message,
    required this.metadata,
    required this.items,
  });

  bool get hasMore => metadata.currentPage < metadata.numberOfPages;

  int get nextPage => metadata.currentPage + 1;

  int? get previousPage => metadata.currentPage > 1 ? metadata.currentPage - 1 : null;
}