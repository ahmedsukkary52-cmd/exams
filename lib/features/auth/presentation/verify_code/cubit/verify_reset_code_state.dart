import '../../../../../core/base/resources.dart';
import '../../../domain/entities/response/forgot_password_response.dart';
import '../../../domain/entities/response/verify_reset_code_response.dart';

class VerifyResetCodeState {
  final Resource<VerifyResetCodeResponse> verifyResetCode;
  final Resource<ForgotPasswordResponse> resendCode;

  const VerifyResetCodeState({
    required this.verifyResetCode,
    required this.resendCode,
  });

  VerifyResetCodeState copyWith({
    Resource<VerifyResetCodeResponse>? verifyResetCode,
    Resource<ForgotPasswordResponse>? resendCode,
  }) {
    return VerifyResetCodeState(
      verifyResetCode: verifyResetCode ?? this.verifyResetCode,
      resendCode: resendCode ?? this.resendCode,
    );
  }
}
