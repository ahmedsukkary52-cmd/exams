import '../../../../core/network/api_result.dart';
import '../entites/request/signup_request.dart';
import '../entites/response/signup_response.dart';

abstract class AuthRepository {
  Future<ApiResult<SignupResponse>> signUp(SignupRequest request);
}
