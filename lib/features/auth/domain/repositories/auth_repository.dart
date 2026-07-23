import '../../../../core/network/api_result.dart';
import '../entities/request/forgot_password_request.dart';
import '../entities/request/reset_password_request.dart';
import '../entities/request/sign_in_request.dart';
import '../entities/request/signup_request.dart';
import '../entities/request/verify_reset_code_request.dart';
import '../entities/response/auth_response.dart';
import '../entities/response/forgot_password_response.dart';
import '../entities/response/reset_password_response.dart';
import '../entities/response/verify_reset_code_response.dart';

abstract class AuthRepository {
  Future<ApiResult<AuthResponse>> signUp(SignupRequest request);

  Future<ApiResult<AuthResponse>> signIn(SignInRequest request);

  Future<ApiResult<ForgotPasswordResponse>> forgotPassword(
    ForgotPasswordRequest request,
  );

  Future<ApiResult<VerifyResetCodeResponse>> verifyResetCode(
    VerifyResetCodeRequest request,
  );

  Future<ApiResult<ResetPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  );
}
