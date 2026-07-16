import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../storage/token_storage.dart';
import 'api_endpoints.dart';

@LazySingleton()
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  // TODO: Remove after implementing login.
  static const String _tempAccessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNGI1MDM2M2ViMzIyMWQzNmFkYTIwMCIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzg0MTI2OTcyfQ.esD28NrzMcqpux1hIGTD2qZxBy8bf7jf6KnRl3D6KlQ';

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    if (ApiEndpoints.publicEndpoints.contains(options.path)) {
      handler.next(options);
      return;
    }

    final token = await _tokenStorage.getAccessToken();

    final accessToken = (token != null && token.isNotEmpty) ? token : _tempAccessToken;

    options.headers['token'] = accessToken;

    handler.next(options);
  }


  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _tokenStorage.clear();
    }

    handler.next(err);
  }
}
