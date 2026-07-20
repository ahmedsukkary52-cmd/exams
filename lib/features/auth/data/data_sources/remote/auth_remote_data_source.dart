import '../../../domain/entities/request/forgot_password_request.dart';
import '../../../domain/entities/request/sign_in_request.dart';
import '../../../domain/entities/request/signup_request.dart';
import '../../../domain/entities/request/verify_reset_code_request.dart';
import '../../../domain/entities/response/auth_response.dart';
import '../../../domain/entities/response/forgot_password_response.dart';
import '../../../domain/entities/response/verify_reset_code_response.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> signUp(SignupRequest request);

  Future<AuthResponse> signIn(SignInRequest request);

  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request);

  Future<VerifyResetCodeResponse> verifyResetCode(
    VerifyResetCodeRequest request,
  );
}
