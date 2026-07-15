import '../../../domain/entites/request/signup_request.dart';
import '../../../domain/entites/response/signup_response.dart';

abstract class AuthRemoteDataSource {
  Future<SignupResponse> signUp(SignupRequest request);
}
