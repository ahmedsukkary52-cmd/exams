import 'package:exams/core/network/api_services/api_services.dart';
import 'package:exams/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exams/features/auth/data/mapper/request/sign_in_request_mapper.dart';
import 'package:exams/features/auth/data/mapper/request/signup_request_mapper.dart';
import 'package:exams/features/auth/data/mapper/response/signup_response_mapper.dart';
import 'package:exams/features/auth/domain/entites/request/sign_in_request.dart';
import 'package:exams/features/auth/domain/entites/request/signup_request.dart';
import 'package:exams/features/auth/domain/entites/response/auth_response.dart';
import 'package:injectable/injectable.dart';

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
}
