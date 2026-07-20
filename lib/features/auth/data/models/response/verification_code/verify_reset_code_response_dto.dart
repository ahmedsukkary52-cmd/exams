import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_response_dto.g.dart';

@JsonSerializable()
class VerifyResetCodeResponseDto {
  final String message;

  const VerifyResetCodeResponseDto({required this.message});

  factory VerifyResetCodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeResponseDtoToJson(this);
}
