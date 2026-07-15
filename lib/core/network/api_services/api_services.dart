import 'package:dio/dio.dart';
import 'package:exams/core/network/api_endpoints.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/auth/data/models/request/signup_request_dto.dart';
import '../../../features/auth/data/models/response/signup_response_dto.dart';
import '../api_constants.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @POST(ApiEndpoints.signup)
  Future<SignupResponseDto> signUp(@Body() SignupRequestDto body);
}
