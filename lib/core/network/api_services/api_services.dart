import 'package:dio/dio.dart';
import 'package:exams/core/network/api_endpoints.dart';
import 'package:exams/features/auth/data/models/request/sign_in_request_dto.dart';
import 'package:exams/features/exam/data/models/response/exams_response_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/auth/data/models/request/signup_request_dto.dart';
import '../../../features/auth/data/models/response/auth_response_dto.dart';
import '../api_constants.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @POST(ApiEndpoints.signup)
  Future<AuthResponseDto> signUp(@Body() SignupRequestDto body);

  @POST(ApiEndpoints.signin)
  Future<AuthResponseDto> signIn(@Body() SignInRequestDto body);

  @GET(ApiEndpoints.getAllExams)
  Future<ExamsResponseDto> getAllExams({
    @Query('page') required int page,
    @Query('limit') required int limit,
  });
}
