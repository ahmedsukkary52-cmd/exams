import 'package:dio/dio.dart';

sealed class AppError {
  final String? message;
  final Exception? exception;

  const AppError({this.message, this.exception});
}

final class TimeoutAppError extends AppError {
  const TimeoutAppError({
    super.message = 'Connection timeout',
    super.exception,
  });
}

final class UnauthorizedAppError extends AppError {
  const UnauthorizedAppError({super.message = 'Unauthorized', super.exception});
}

final class ValidationAppError extends AppError {
  const ValidationAppError({super.message, super.exception});
}

final class ServerAppError extends AppError {
  const ServerAppError({super.message = 'Server error', super.exception});
}

final class NetworkAppError extends AppError {
  const NetworkAppError({
    super.message = 'No Internet Connection',
    super.exception,
  });
}

final class UnknownAppError extends AppError {
  const UnknownAppError({
    super.message = 'Something went wrong',
    super.exception,
  });
}

abstract final class ErrorParser {
  static AppError parse(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return TimeoutAppError(exception: exception);

      case DioExceptionType.connectionError:
        return NetworkAppError(exception: exception);

      case DioExceptionType.badResponse:
        return _handleBadResponse(exception);

      default:
        return UnknownAppError(exception: exception);
    }
  }

  static AppError _handleBadResponse(DioException exception) {
    final statusCode = exception.response?.statusCode;

    final data = exception.response?.data;

    final message = data is Map<String, dynamic>
        ? data['message']?.toString()
        : null;

    switch (statusCode) {
      case 400:
      case 422:
        return ValidationAppError(
          message: message ?? 'Validation error',
          exception: exception,
        );

      case 401:
        return UnauthorizedAppError(exception: exception);

      case 500:
      case 502:
      case 503:
        return ServerAppError(
          message: message ?? 'Server error',
          exception: exception,
        );

      default:
        return UnknownAppError(message: message, exception: exception);
    }
  }
}
