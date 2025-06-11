import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_response.freezed.dart';
part 'register_response.g.dart';

@freezed
abstract class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({
    MetaResponse? meta,
    RegisterDataResponse? data,
  }) = _RegisterResponse;

  const RegisterResponse._();

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  RegisterEntity toEntity() => RegisterEntity(
        meta: meta?.toEntity(),
        data: data?.toEntity(),
      );
}

@freezed
abstract class RegisterDataResponse with _$RegisterDataResponse {
  const factory RegisterDataResponse({
    String? status,
    String? message,
    String? token,
    Map<String, List<String>>? error,
  }) = _RegisterDataResponse;

  const RegisterDataResponse._();

  factory RegisterDataResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataResponseFromJson(json);

  RegisterDataEntity toEntity() => RegisterDataEntity(
        status: status,
        message: message,
        token: token,
        error: error != null ? RegisterErrorEntity(fields: error) : null,
      );
}
