import '../../../domain/entities/response/verify_reset_code_response.dart';
import '../../models/response/verification_code/verify_reset_code_response_dto.dart';

extension VerifyResetCodeResponseMapper on VerifyResetCodeResponseDto {
  VerifyResetCodeResponse toEntity() {
    return VerifyResetCodeResponse(message: message);
  }
}
