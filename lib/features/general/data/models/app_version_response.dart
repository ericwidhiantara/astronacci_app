import 'package:boilerplate/features/features.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version_response.freezed.dart';
part 'app_version_response.g.dart';

@freezed
abstract class AppVersionResponse with _$AppVersionResponse {
  const factory AppVersionResponse({
    String? message,
    VersionDataResponse? data,
    int? status,
  }) = _AppVersionResponse;

  const AppVersionResponse._();

  factory AppVersionResponse.fromJson(Map<String, dynamic> json) =>
      _$AppVersionResponseFromJson(json);

  AppVersionEntity toEntity() {
    return AppVersionEntity(
      message: message,
      data: data?.toEntity(),
      status: status,
    );
  }
}

@freezed
abstract class VersionDataResponse with _$VersionDataResponse {
  const factory VersionDataResponse({
    int? id,
    @JsonKey(name: 'app_version') String? appVersion,
    @JsonKey(name: 'app_store_url') String? appStoreUrl,
    @JsonKey(name: 'play_store_url') String? playStoreUrl,
    String? whatsapp,
    String? email,
  }) = _VersionDataResponse;

  const VersionDataResponse._();

  factory VersionDataResponse.fromJson(Map<String, dynamic> json) =>
      _$VersionDataResponseFromJson(json);

  VersionDataEntity toEntity() {
    return VersionDataEntity(
      id: id,
      appVersion: appVersion,
      appStoreUrl: appStoreUrl,
      playStoreUrl: playStoreUrl,
      whatsapp: whatsapp,
      email: email,
    );
  }
}
