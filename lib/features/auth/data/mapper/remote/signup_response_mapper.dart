import 'package:exams/features/auth/data/mapper/remote/user_response_mapper.dart';
import 'package:exams/features/auth/data/models/response/signup_response_dto.dart';
import 'package:exams/features/auth/domain/entites/response/signup_response.dart';

extension SignupResponseMapper on SignupResponseDto {
  SignupResponse toSignupResponse() {
    return SignupResponse(
      message: message,
      token: token,
      user: user?.toUserEntity(),
    );
  }
}
