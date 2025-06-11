import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
abstract class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    MetaResponse? meta,
    LoginDataResponse? data,
  }) = _LoginResponse;

  const LoginResponse._();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  LoginEntity toEntity() => LoginEntity(
        meta: meta?.toEntity(),
        data: data?.toEntity(),
      );
}

@freezed
abstract class LoginDataResponse with _$LoginDataResponse {
  const factory LoginDataResponse({
    String? status,
    String? message,
    String? token,
  }) = _LoginDataResponse;

  const LoginDataResponse._();

  factory LoginDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginDataResponseFromJson(json);

  LoginDataEntity toEntity() => LoginDataEntity(
        status: status,
        message: message,
        token: token,
      );
}
