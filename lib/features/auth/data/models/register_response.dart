import 'package:boilerplate/features/features.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_response.freezed.dart';

part 'register_response.g.dart';

@freezed
abstract class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({
    int? id,
    String? token,
    String? error,
  }) = _RegisterResponse;

  const RegisterResponse._();

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Register toEntity() => Register(token: token);
}
