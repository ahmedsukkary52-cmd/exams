import 'package:exams/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../entities/request/forgot_password_request.dart';
import '../entities/response/forgot_password_response.dart';

@lazySingleton
class ForgotPasswordUseCase {
  final AuthRepository repository;

  const ForgotPasswordUseCase(this.repository);

  Future<ApiResult<ForgotPasswordResponse>> call(
    ForgotPasswordRequest request,
  ) {
    return repository.forgotPassword(request);
  }
}
