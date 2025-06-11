import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_entity.freezed.dart';

@freezed
abstract class RegisterEntity with _$RegisterEntity {
  const factory RegisterEntity({
    MetaEntity? meta,
    RegisterDataEntity? data,
  }) = _RegisterEntity;

  const RegisterEntity._();
}

@freezed
abstract class RegisterDataEntity with _$RegisterDataEntity {
  const factory RegisterDataEntity({
    String? status,
    String? message,
    String? token,
    RegisterErrorEntity? error,
  }) = _RegisterDataEntity;

  const RegisterDataEntity._();
}

@freezed
abstract class RegisterErrorEntity with _$RegisterErrorEntity {
  const factory RegisterErrorEntity({
    Map<String, List<String>>? fields,
  }) = _RegisterErrorEntity;

  const RegisterErrorEntity._();
}
