import 'metadata_entity.dart';

abstract class ResponseEntity<T> {
  final String message;
  final MetadataEntity metadata;
  final List<T> items;

  const ResponseEntity({
    required this.message,
    required this.metadata,
    required this.items,
  });

  bool get hasMore => metadata.currentPage < metadata.numberOfPages;

  int get nextPage => metadata.currentPage + 1;
}