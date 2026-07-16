import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/safe_call.dart';
import '../../domain/entites/request/signup_request.dart';
import '../../domain/entites/response/signup_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/remote/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<SignupResponse>> signUp(SignupRequest request) {
    return safeCall(() async {
      final response = await remoteDataSource.signUp(request);
      return Success(response);
    });
  }
}
