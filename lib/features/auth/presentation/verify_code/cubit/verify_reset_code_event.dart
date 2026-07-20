import '../../../domain/entities/request/forgot_password_request.dart';
import '../../../domain/entities/request/verify_reset_code_request.dart';

sealed class VerifyResetCodeEvent {}

class VerifyResetCodeCompleted extends VerifyResetCodeEvent {
  final VerifyResetCodeRequest request;

  VerifyResetCodeCompleted(this.request);
}

class ResendCodePressed extends VerifyResetCodeEvent {
  final ForgotPasswordRequest request;

  ResendCodePressed(this.request);
}
