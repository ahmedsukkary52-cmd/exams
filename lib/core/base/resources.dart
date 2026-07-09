enum Status {
  initial,
  loading,
  success,
  error,
}

class Resource<T> {
  final Status status;
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
    status: Status.initial,
  );

  const Resource.loading()
      : this._(
    status: Status.loading,
  );

  const Resource.success(T data)
      : this._(
    status: Status.success,
    data: data,
  );

  const Resource.error({
    String? message,
    Exception? exception,
  }) : this._(
    status: Status.error,
    message: message,
    exception: exception,
  );
}