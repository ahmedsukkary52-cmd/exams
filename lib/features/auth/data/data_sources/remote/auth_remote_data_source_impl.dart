import 'package:exams/core/network/api_services/api_services.dart';
import 'package:exams/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exams/features/auth/data/mapper/remote/signup_response_mapper.dart';
import 'package:exams/features/auth/data/mapper/request/signup_request_mapper.dart';
import 'package:exams/features/auth/domain/entites/request/signup_request.dart';
import 'package:exams/features/auth/domain/entites/response/signup_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiServices apiServices;

  AuthRemoteDataSourceImpl(this.apiServices);

  @override
  Future<SignupResponse> signUp(SignupRequest request) async {
    final response = await apiServices.signUp(request.toSignupRequestDto());
    return response.toSignupResponse();
  }
}
