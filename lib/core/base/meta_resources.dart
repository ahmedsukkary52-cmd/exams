import 'package:exams/core/base/resources.dart';
import '../../features/exam/domain/entities/paginated_entity.dart';

class MetaResource<T extends PaginatedEntity<dynamic>> {
  final Status status;
  final T? data;
  final String? message;
  final Exception? exception;

  const MetaResource._({
    required this.status,
    this.data,
    this.message,
    this.exception,
  });

  const MetaResource.initial() : this._(status: Status.initial);

  const MetaResource.loading({T? data}) : this._(
    status: Status.loading,
    data: data,
  );

  const MetaResource.success(T data)
      : this._(
    status: Status.success,
    data: data,
  );

  const MetaResource.error({
    T? data,
    String? message,
    Exception? exception,
  }) : this._(
    status: Status.error,
    data: data,
    message: message,
    exception: exception,
  );

  bool get hasMore => data?.hasMore ?? true;

  int get nextPage => data?.nextPage ?? 1;

  int? get previousPage => data?.previousPage;
}