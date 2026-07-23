import 'package:exams/core/network/api_services/api_services.dart';
import 'package:exams/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exams/features/auth/data/mappers/request/sign_in_request_mapper.dart';
import 'package:exams/features/auth/data/mappers/request/signup_request_mapper.dart';
import 'package:exams/features/auth/data/mappers/response/signup_response_mapper.dart';
import 'package:exams/features/auth/domain/entities/request/forgot_password_request.dart';
import 'package:exams/features/auth/domain/entities/request/reset_password_request.dart';
import 'package:exams/features/auth/domain/entities/request/sign_in_request.dart';
import 'package:exams/features/auth/domain/entities/request/signup_request.dart';
import 'package:exams/features/auth/domain/entities/response/auth_response.dart';
import 'package:exams/features/auth/domain/entities/response/forgot_password_response.dart';
import 'package:exams/features/auth/domain/entities/response/reset_password_response.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/request/verify_reset_code_request.dart';
import '../../../domain/entities/response/verify_reset_code_response.dart';
import '../../mappers/response/forgot_password_response_mapper.dart';
import '../../mappers/response/reset_password_response_mapper.dart';
import '../../mappers/response/verify_reset_code_response_mapper.dart';
import '../../models/response/forgot_password/forgot_password_response_dto.dart';
import '../../models/response/reset_password/reset_password_response_dto.dart';
import '../../models/response/verification_code/verify_reset_code_response_dto.dart';

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

  @override
  Future<VerifyResetCodeResponse> verifyResetCode(
    VerifyResetCodeRequest request,
  ) async {
    /// Fake implementation until forgot password endpoint is ready. ___________________________________
    await Future.delayed(const Duration(seconds: 1));

    return const VerifyResetCodeResponseDto(
      message: 'Code verified successfully',
    ).toEntity();
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
    ResetPasswordRequest request,
  ) async {
    /// Fake implementation until forgot password endpoint is ready. ___________________________________
    await Future.delayed(const Duration(seconds: 1));

    return const ResetPasswordResponseDto(
      message: 'Password reset successfully',
    ).toEntity();
  }
}
