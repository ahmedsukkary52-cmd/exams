import 'package:dio/dio.dart';

import 'api_result.dart';
import 'app_error.dart';

Future<ApiResult<T>> safeCall<T>(Future<ApiResult<T>> Function() call,) async {
  try {
    return await call();
  } on DioException catch (e) {
    final error = ErrorParser.parse(e);
    return Failure(error);
  } catch (e) {
    return Failure(
      UnknownAppError(
        exception: e is Exception ? e : Exception(e.toString()),
      ),
    );
  }
}