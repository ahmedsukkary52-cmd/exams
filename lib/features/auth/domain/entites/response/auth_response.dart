import 'package:exams/features/auth/domain/entites/response/user_entity.dart';

class AuthResponse {
  final String? message;
  final String? token;
  final UserEntity? user;

  AuthResponse({this.message, this.token, this.user});
}
