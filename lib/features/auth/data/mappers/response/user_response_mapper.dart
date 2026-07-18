import 'package:exams/features/auth/data/models/response/user/user_dto.dart';
import 'package:exams/features/auth/domain/entites/response/user_entity.dart';

extension UserResponseMapper on UserDto {
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      createdAt: createdAt,
      email: email,
      firstName: firstName,
      isVerified: isVerified,
      lastName: lastName,
      phone: phone,
      role: role,
      username: username,
    );
  }
}
