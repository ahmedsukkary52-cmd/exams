import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../entities/request/signup_request.dart';
import '../entities/response/auth_response.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignupUseCase {
  final AuthRepository repository;

  const SignupUseCase(this.repository);

  Future<ApiResult<AuthResponse>> call(SignupRequest request) {
    return repository.signUp(request);
  }
}
