import '../../../domain/entites/request/sign_in_request.dart';
import '../../models/request/sign_in_request_dto.dart';

extension SignInRequestMapper on SignInRequest {
  SignInRequestDto toSignInRequestDto() {
    return SignInRequestDto(email: email, password: password);
  }
}
