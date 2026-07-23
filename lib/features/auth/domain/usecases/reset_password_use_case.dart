import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../entities/request/reset_password_request.dart';
import '../entities/response/reset_password_response.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class ResetPasswordUseCase {
  final AuthRepository repository;

  const ResetPasswordUseCase(this.repository);

  Future<ApiResult<ResetPasswordResponse>> call(ResetPasswordRequest request) {
    return repository.resetPassword(request);
  }
}
