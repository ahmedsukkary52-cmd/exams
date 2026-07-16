import '../../../../core/base/resources.dart';
import '../../domain/entites/response/signup_response.dart';

class AuthState {
  final Resource<SignupResponse> signup;
  final bool isFormValid;

  AuthState(this.signup, {this.isFormValid = false});

  AuthState copyWith({Resource<SignupResponse>? signup, bool? isFormValid}) {
    return AuthState(
      signup ?? this.signup,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
