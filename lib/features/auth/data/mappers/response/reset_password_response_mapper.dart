import '../../../domain/entities/response/reset_password_response.dart';
import '../../models/response/reset_password/reset_password_response_dto.dart';

extension ResetPasswordResponseMapper on ResetPasswordResponseDto {
  ResetPasswordResponse toEntity() {
    return ResetPasswordResponse(message: message);
  }
}
