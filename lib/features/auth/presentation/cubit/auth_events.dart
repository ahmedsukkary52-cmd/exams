import '../../domain/entites/request/signup_request.dart';

sealed class AuthEvents {}

class SignupPressed extends AuthEvents {
  final SignupRequest request;

  SignupPressed(this.request);
}

class SignupFormChanged extends AuthEvents {
  final bool isValid;

  SignupFormChanged(this.isValid);
}
