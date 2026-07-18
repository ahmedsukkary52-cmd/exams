import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../entites/request/sign_in_request.dart';
import '../entites/response/auth_response.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignInUseCase {
  final AuthRepository repository;

  const SignInUseCase(this.repository);

  Future<ApiResult<AuthResponse>> call(SignInRequest request) {
    return repository.signIn(request);
  }
}
