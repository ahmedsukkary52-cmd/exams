import '../../../domain/entities/request/reset_password_request.dart';

sealed class ResetPasswordEvent {}

class ResetPasswordPressed extends ResetPasswordEvent {
  final ResetPasswordRequest request;

  ResetPasswordPressed(this.request);
}

class ResetPasswordFormChanged extends ResetPasswordEvent {
  final bool isValid;

  ResetPasswordFormChanged(this.isValid);
}
