import 'package:exams/features/auth/domain/entites/response/user_entity.dart';

class SignupResponse {
  final String? message;
  final String? token;
  final UserEntity? user;

  SignupResponse({this.message, this.token, this.user});
}
