import '../../../../../core/base/resources.dart';
import '../../../domain/entities/response/reset_password_response.dart';

class ResetPasswordState {
  final Resource<ResetPasswordResponse> resetPassword;
  final bool isFormValid;

  const ResetPasswordState({
    required this.resetPassword,
    this.isFormValid = false,
  });

  ResetPasswordState copyWith({
    Resource<ResetPasswordResponse>? resetPassword,
    bool? isFormValid,
  }) {
    return ResetPasswordState(
      resetPassword: resetPassword ?? this.resetPassword,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
