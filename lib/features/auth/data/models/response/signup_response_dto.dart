import 'package:exams/features/auth/data/models/response/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_response_dto.g.dart';

@JsonSerializable()
class SignupResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "user")
  final UserDto? user;

  SignupResponseDto({this.message, this.token, this.user});

  factory SignupResponseDto.fromJson(Map<String, dynamic> json) {
    return _$SignupResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignupResponseDtoToJson(this);
  }
}
