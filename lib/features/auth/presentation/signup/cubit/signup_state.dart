import '../../../../../core/base/resources.dart';
import '../../../domain/entities/response/auth_response.dart';

class SignupState {
  final Resource<AuthResponse> signup;
  final bool isFormValid;

  SignupState(this.signup, {this.isFormValid = false});

  SignupState copyWith({Resource<AuthResponse>? signup, bool? isFormValid}) {
    return SignupState(
      signup ?? this.signup,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
