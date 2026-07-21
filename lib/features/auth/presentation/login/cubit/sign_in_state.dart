import '../../../../../core/base/resources.dart';
import '../../../domain/entities/response/auth_response.dart';

class SignInState {
  final Resource<AuthResponse> auth;
  final bool isFormValid;
  final bool rememberMe;

  SignInState({
    required this.auth,
    this.isFormValid = false,
    this.rememberMe = false,
  });

  SignInState copyWith({
    Resource<AuthResponse>? auth,
    bool? isFormValid,
    bool? rememberMe,
  }) {
    return SignInState(
      auth: auth ?? this.auth,
      isFormValid: isFormValid ?? this.isFormValid,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
