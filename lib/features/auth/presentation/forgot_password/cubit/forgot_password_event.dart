import 'package:exams/features/auth/domain/entites/request/forgot_password_request.dart';

sealed class ForgotPasswordEvent {}

class ForgotPasswordPressed extends ForgotPasswordEvent {
  final ForgotPasswordRequest request;

  ForgotPasswordPressed(this.request);
}

class ForgotPasswordFormChanged extends ForgotPasswordEvent {
  final bool isValid;

  ForgotPasswordFormChanged(this.isValid);
}
