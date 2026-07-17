import '../../../domain/entites/request/signup_request.dart';

sealed class SignupEvents {}

class SignupPressed extends SignupEvents {
  final SignupRequest request;

  SignupPressed(this.request);
}

class SignupFormChanged extends SignupEvents {
  final bool isValid;

  SignupFormChanged(this.isValid);
}
