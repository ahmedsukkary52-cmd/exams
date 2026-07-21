import '../../../domain/entities/request/sign_in_request.dart';

sealed class SignInEvents {}

class SignInPressed extends SignInEvents {
  final SignInRequest request;

  SignInPressed(this.request);
}

class SignInFormChanged extends SignInEvents {
  final bool isValid;

  SignInFormChanged(this.isValid);
}

class RememberMeChanged extends SignInEvents {
  final bool value;

  RememberMeChanged(this.value);
}
