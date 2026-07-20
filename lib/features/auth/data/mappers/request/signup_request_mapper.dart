import 'package:exams/features/auth/data/models/request/login/signup_request_dto.dart';
import 'package:exams/features/auth/domain/entities/request/signup_request.dart';

extension SignupRequestMapper on SignupRequest {
  SignupRequestDto toSignupRequestDto() {
    return SignupRequestDto(
      username: username,
      phone: phone,
      lastName: lastName,
      email: email,
      firstName: firstName,
      password: password,
      rePassword: rePassword,
    );
  }
}
