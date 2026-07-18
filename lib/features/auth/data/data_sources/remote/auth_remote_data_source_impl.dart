import 'package:exams/core/network/api_services/api_services.dart';
import 'package:exams/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exams/features/auth/data/mappers/request/sign_in_request_mapper.dart';
import 'package:exams/features/auth/data/mappers/request/signup_request_mapper.dart';
import 'package:exams/features/auth/data/mappers/response/signup_response_mapper.dart';
import 'package:exams/features/auth/domain/entites/request/forgot_password_request.dart';
import 'package:exams/features/auth/domain/entites/request/sign_in_request.dart';
import 'package:exams/features/auth/domain/entites/request/signup_request.dart';
import 'package:exams/features/auth/domain/entites/response/auth_response.dart';
import 'package:exams/features/auth/domain/entites/response/forgot_password_response.dart';
import 'package:injectable/injectable.dart';

import '../../mappers/response/forgot_password_response_mapper.dart';
import '../../models/response/forgot_password/forgot_password_response_dto.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiServices apiServices;

  AuthRemoteDataSourceImpl(this.apiServices);

  @override
  Future<AuthResponse> signUp(SignupRequest request) async {
    final response = await apiServices.signUp(request.toSignupRequestDto());
    return response.toSignupResponse();
  }

  @override
  Future<AuthResponse> signIn(SignInRequest request) async {
    final response = await apiServices.signIn(request.toSignInRequestDto());
    return response.toSignupResponse();
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    /// Fake implementation until the backend endpoint is ready. ___________________________________
    await Future.delayed(const Duration(seconds: 1));

    return ForgotPasswordResponseDto(
      message: "OTP sent successfully",
    ).toForgotPasswordResponse();
  }
}
