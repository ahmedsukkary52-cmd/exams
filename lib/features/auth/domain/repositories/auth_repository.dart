import '../../../../core/network/api_result.dart';
import '../entites/request/sign_in_request.dart';
import '../entites/request/signup_request.dart';
import '../entites/response/auth_response.dart';

abstract class AuthRepository {
  Future<ApiResult<AuthResponse>> signUp(SignupRequest request);

  Future<ApiResult<AuthResponse>> signIn(SignInRequest request);
}
