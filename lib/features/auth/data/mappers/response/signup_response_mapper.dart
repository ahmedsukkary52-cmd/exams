import 'package:exams/features/auth/data/mappers/response/user_response_mapper.dart';
import 'package:exams/features/auth/data/models/response/auth_response/auth_response_dto.dart';
import 'package:exams/features/auth/domain/entites/response/auth_response.dart';

extension SignupResponseMapper on AuthResponseDto {
  AuthResponse toSignupResponse() {
    return AuthResponse(
      message: message,
      token: token,
      user: user?.toUserEntity(),
    );
  }
}
