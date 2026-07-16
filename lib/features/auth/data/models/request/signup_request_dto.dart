import 'package:json_annotation/json_annotation.dart';

part 'signup_request_dto.g.dart';

@JsonSerializable()
class SignupRequestDto {
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "rePassword")
  final String? rePassword;
  @JsonKey(name: "phone")
  final String? phone;

  SignupRequestDto({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
  });

  factory SignupRequestDto.fromJson(Map<String, dynamic> json) {
    return _$SignupRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignupRequestDtoToJson(this);
  }
}
