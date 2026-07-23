import '../../../domain/entities/request/reset_password_request.dart';
import '../../models/request/reset_password/reset_password_request_dto.dart';

extension ResetPasswordRequestMapper on ResetPasswordRequest {
  ResetPasswordRequestDto toResetPasswordRequestDto() {
    return ResetPasswordRequestDto(email: email, newPassword: newPassword);
  }
}
