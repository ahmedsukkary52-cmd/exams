import '../../../domain/entites/request/forgot_password_request.dart';
import '../../models/request/forget_password/forgot_password_request_dto.dart';

extension ForgotPasswordRequestMapper on ForgotPasswordRequest {
  ForgotPasswordRequestDto toForgotPasswordRequestDto() {
    return ForgotPasswordRequestDto(email: email);
  }
}
