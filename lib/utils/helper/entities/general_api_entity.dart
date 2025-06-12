import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_api_entity.freezed.dart';

@freezed
abstract class GeneralAPIEntity with _$GeneralAPIEntity {
  const factory GeneralAPIEntity({
    MetaEntity? meta,
    GeneralDataAPIEntity? data,
  }) = _GeneralAPIEntity;

  const GeneralAPIEntity._();
}

@freezed
abstract class GeneralDataAPIEntity with _$GeneralDataAPIEntity {
  const factory GeneralDataAPIEntity({
    bool? success,
    String? message,
  }) = _GeneralDataAPIEntity;

  const GeneralDataAPIEntity._();
}
