import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_entity.freezed.dart';

@freezed
abstract class LoginEntity with _$LoginEntity {
  const factory LoginEntity({
    MetaEntity? meta,
    LoginDataEntity? data,
  }) = _LoginEntity;

  const LoginEntity._();
}

@freezed
abstract class LoginDataEntity with _$LoginDataEntity {
  const factory LoginDataEntity({
    String? status,
    String? message,
    String? token,
  }) = _LoginDataEntity;

  const LoginDataEntity._();
}
