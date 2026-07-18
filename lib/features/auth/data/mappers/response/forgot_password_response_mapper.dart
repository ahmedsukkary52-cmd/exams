import '../../../domain/entites/response/forgot_password_response.dart';
import '../../models/response/forgot_password/forgot_password_response_dto.dart';

extension ForgotPasswordResponseMapper on ForgotPasswordResponseDto {
  ForgotPasswordResponse toForgotPasswordResponse() {
    return ForgotPasswordResponse(message: message);
  }
}
