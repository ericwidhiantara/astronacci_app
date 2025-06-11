import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta_entity.freezed.dart';

@freezed
abstract class MetaEntity with _$MetaEntity {
  const factory MetaEntity({
    String? status,
    int? code,
    String? message,
  }) = _MetaEntity;

  const MetaEntity._();
}
