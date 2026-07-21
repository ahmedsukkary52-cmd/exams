enum ResourceStatus {
  initial,
  loading,
  success,
  error,
}

class Resource<T> {
  final ResourceStatus status;
  final T? data;
  final String? message;
  final Exception? exception;

  const Resource._({
    required this.status,
    this.data,
    this.message,
    this.exception,
  });

  const Resource.initial()
      : this._(
    status: ResourceStatus.initial,
  );

  const Resource.loading()
      : this._(
    status: ResourceStatus.loading,
  );

  const Resource.success(T data)
      : this._(
    status: ResourceStatus.success,
    data: data,
  );

  const Resource.error({
    String? message,
    Exception? exception,
  }) : this._(
    status: ResourceStatus.error,
    message: message,
    exception: exception,
  );
}