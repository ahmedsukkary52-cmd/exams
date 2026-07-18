import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response_dto.g.dart';

@JsonSerializable()
class ForgotPasswordResponseDto {
  @JsonKey(name: "message")
  final String? message;

  ForgotPasswordResponseDto({this.message});

  factory ForgotPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ForgotPasswordResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgotPasswordResponseDtoToJson(this);
  }
}
