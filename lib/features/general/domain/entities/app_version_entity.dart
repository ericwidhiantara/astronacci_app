import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version_entity.freezed.dart';

@freezed
abstract class AppVersionEntity with _$AppVersionEntity {
  const factory AppVersionEntity({
    MetaEntity? meta,
    VersionDataEntity? data,
  }) = _AppVersionEntity;

  const AppVersionEntity._();
}

@freezed
abstract class VersionDataEntity with _$VersionDataEntity {
  const factory VersionDataEntity({
    int? id,
    String? appVersion,
    String? appStoreUrl,
    String? playStoreUrl,
    String? whatsapp,
    String? email,
  }) = _VersionDataEntity;

  const VersionDataEntity._();
}
