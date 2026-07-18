import '../../../domain/entites/request/sign_in_request.dart';
import '../../../domain/entites/request/signup_request.dart';
import '../../../domain/entites/response/auth_response.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> signUp(SignupRequest request);

  Future<AuthResponse> signIn(SignInRequest request);
}
