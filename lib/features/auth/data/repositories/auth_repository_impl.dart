import 'package:exams/features/auth/domain/entites/request/forgot_password_request.dart';
import 'package:exams/features/auth/domain/entites/request/sign_in_request.dart';
import 'package:exams/features/auth/domain/entites/response/forgot_password_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/safe_call.dart';
import '../../domain/entites/request/signup_request.dart';
import '../../domain/entites/response/auth_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/remote/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<AuthResponse>> signUp(SignupRequest request) {
    return safeCall(() async {
      final response = await remoteDataSource.signUp(request);
      return Success(response);
    });
  }

  @override
  Future<ApiResult<AuthResponse>> signIn(SignInRequest request) {
    return safeCall(() async {
      final response = await remoteDataSource.signIn(request);
      return Success(response);
    });
  }

  @override
  Future<ApiResult<ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest request) {
    return safeCall(() async {
      final response = await remoteDataSource.forgotPassword(request);
      return Success(response);
    });
  }
}
