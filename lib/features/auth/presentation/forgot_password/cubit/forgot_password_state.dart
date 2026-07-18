import 'package:exams/features/auth/domain/entites/response/forgot_password_response.dart';

import '../../../../../core/base/resources.dart';

class ForgotPasswordState {
  final Resource<ForgotPasswordResponse> forgotPassword;
  final bool isFormValid;

  ForgotPasswordState({required this.forgotPassword, this.isFormValid = false});

  ForgotPasswordState copyWith({
    Resource<ForgotPasswordResponse>? forgotPassword,
    bool? isFormValid,
  }) {
    return ForgotPasswordState(
      forgotPassword: forgotPassword ?? this.forgotPassword,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
