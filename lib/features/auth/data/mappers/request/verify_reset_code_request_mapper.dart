import '../../../domain/entities/request/verify_reset_code_request.dart';
import '../../models/request/verification_code/verify_reset_code_request_dto.dart';

extension VerifyResetCodeRequestMapper on VerifyResetCodeRequest {
  VerifyResetCodeRequestDto toDto() {
    return VerifyResetCodeRequestDto(resetCode: resetCode);
  }
}
