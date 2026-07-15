import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../entites/request/signup_request.dart';
import '../entites/response/signup_response.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignupUseCase {
  final AuthRepository repository;

  const SignupUseCase(this.repository);

  Future<ApiResult<SignupResponse>> call(SignupRequest request) {
    return repository.signUp(request);
  }
}
