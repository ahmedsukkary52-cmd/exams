import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../entities/request/verify_reset_code_request.dart';
import '../entities/response/verify_reset_code_response.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class VerifyResetCodeUseCase {
  final AuthRepository repository;

  const VerifyResetCodeUseCase(this.repository);

  Future<ApiResult<VerifyResetCodeResponse>> call(
    VerifyResetCodeRequest request,
  ) {
    return repository.verifyResetCode(request);
  }
}
