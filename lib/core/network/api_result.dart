import 'app_error.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

final class Success<T> extends ApiResult<T> {
  final T data;

  const Success(this.data);
}

final class Failure<T> extends ApiResult<T> {
  final AppError error;

  const Failure(this.error);
}